#!/usr/bin/env php
<?php
/**
 * get_meta.php - Collects git metadata from all kits and saves to JSON
 * 
 * This script traverses kits/agents/ and kits/commands/ directories,
 * extracts git remote information, and creates a metadata JSON file.
 */

// Configuration
$baseDir = dirname(__DIR__);
$kitsDir = $baseDir . '/kits';
$dataDir = $baseDir . '/data';
$outputFile = $dataDir . '/kits_metadata.json';

// Ensure data directory exists
if (!is_dir($dataDir)) {
    mkdir($dataDir, 0755, true);
}

/**
 * Get git remote URL from a directory
 * @param string $dir Directory path
 * @return string|null Git remote URL or null if not found
 */
function getGitRemoteUrl($dir) {
    if (!is_dir($dir . '/.git')) {
        return null;
    }
    
    // Change to the directory and run git remote -v
    $originalDir = getcwd();
    chdir($dir);
    
    $output = [];
    $returnVar = 0;
    exec('git remote -v 2>/dev/null', $output, $returnVar);
    
    chdir($originalDir);
    
    if ($returnVar !== 0 || empty($output)) {
        return null;
    }
    
    // Parse output to find fetch URL
    foreach ($output as $line) {
        if (preg_match('/^origin\s+(.+?)\s+\(fetch\)/', $line, $matches)) {
            return $matches[1];
        }
    }
    
    return null;
}

/**
 * Get basic kit information
 * @param string $kitPath Path to kit directory
 * @return array Kit information
 */
function getKitInfo($kitPath) {
    $info = [
        'name' => basename($kitPath),
        'path' => $kitPath,
        'repo_url' => getGitRemoteUrl($kitPath),
        'has_readme' => file_exists($kitPath . '/README.md'),
        'last_modified' => null,
        'size' => 0
    ];
    
    // Get last modified time
    if ($info['has_readme']) {
        $info['last_modified'] = date('Y-m-d H:i:s', filemtime($kitPath . '/README.md'));
    }
    
    // Calculate total size of kit
    $iterator = new RecursiveIteratorIterator(
        new RecursiveDirectoryIterator($kitPath, RecursiveDirectoryIterator::SKIP_DOTS),
        RecursiveIteratorIterator::LEAVES_ONLY
    );
    
    foreach ($iterator as $file) {
        if ($file->isFile()) {
            $info['size'] += $file->getSize();
        }
    }
    
    // Convert size to human readable format
    $info['size_human'] = formatBytes($info['size']);
    
    return $info;
}

/**
 * Format bytes to human readable format
 * @param int $bytes
 * @param int $precision
 * @return string
 */
function formatBytes($bytes, $precision = 2) {
    $units = ['B', 'KB', 'MB', 'GB', 'TB'];
    
    $bytes = max($bytes, 0);
    $pow = floor(($bytes ? log($bytes) : 0) / log(1024));
    $pow = min($pow, count($units) - 1);
    
    $bytes /= (1 << (10 * $pow));
    
    return round($bytes, $precision) . ' ' . $units[$pow];
}

/**
 * Scan directory for kits
 * @param string $dir Directory to scan
 * @return array Array of kit information
 */
function scanKitsDirectory($dir) {
    $kits = [];
    
    if (!is_dir($dir)) {
        return $kits;
    }
    
    $dirs = glob($dir . '/*', GLOB_ONLYDIR);
    
    foreach ($dirs as $kitDir) {
        $kitInfo = getKitInfo($kitDir);
        $kits[] = $kitInfo;
    }
    
    return $kits;
}

// Main execution
echo "Leamas Kit Metadata Collector\n";
echo "=============================\n\n";

$metadata = [
    'generated_at' => date('Y-m-d H:i:s'),
    'generator' => 'get_meta.php',
    'version' => '1.0.0',
    'agents' => [],
    'commands' => [],
    'summary' => [
        'total_agent_kits' => 0,
        'total_command_kits' => 0,
        'total_size' => 0
    ]
];

// Scan agent kits
echo "Scanning agent kits...\n";
$agentKits = scanKitsDirectory($kitsDir . '/agents');
$metadata['agents'] = $agentKits;
$metadata['summary']['total_agent_kits'] = count($agentKits);

foreach ($agentKits as $kit) {
    echo "  - {$kit['name']}";
    if ($kit['repo_url']) {
        echo " [{$kit['repo_url']}]";
    }
    echo " ({$kit['size_human']})\n";
    $metadata['summary']['total_size'] += $kit['size'];
}

// Scan command kits
echo "\nScanning command kits...\n";
$commandKits = scanKitsDirectory($kitsDir . '/commands');
$metadata['commands'] = $commandKits;
$metadata['summary']['total_command_kits'] = count($commandKits);

foreach ($commandKits as $kit) {
    echo "  - {$kit['name']}";
    if ($kit['repo_url']) {
        echo " [{$kit['repo_url']}]";
    }
    echo " ({$kit['size_human']})\n";
    $metadata['summary']['total_size'] += $kit['size'];
}

// Add human readable total size
$metadata['summary']['total_size_human'] = formatBytes($metadata['summary']['total_size']);

// Save to JSON file
$json = json_encode($metadata, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES);
file_put_contents($outputFile, $json);

echo "\n";
echo "Summary:\n";
echo "--------\n";
echo "Agent kits found: {$metadata['summary']['total_agent_kits']}\n";
echo "Command kits found: {$metadata['summary']['total_command_kits']}\n";
echo "Total size: {$metadata['summary']['total_size_human']}\n";
echo "\n";
echo "Metadata saved to: $outputFile\n";
echo "Done!\n";
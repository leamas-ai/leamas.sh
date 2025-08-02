# 待办事项应用 UI/UX 设计规范

---
project_name: "待办事项应用"
version: "1.0.0"
created_date: "2025-01-27"
framework_target: "React"
css_approach: "Tailwind CSS + CSS Modules"
---

## 1. 项目概述

### 1.1 设计愿景
创建一个简洁、高效、令人愉悦的待办事项管理应用，让用户能够轻松组织日常任务，提高生产力。

### 1.2 核心用户目标
- 快速创建和管理任务
- 清晰的任务组织和优先级管理
- 直观的进度追踪
- 无干扰的专注体验

### 1.3 设计原则
1. **极简主义**: 只展示必要信息，避免视觉噪音
2. **渐进式披露**: 按需展示高级功能，降低初始复杂度
3. **响应式设计**: 完美适配所有设备尺寸
4. **可访问性优先**: 确保所有用户都能使用
5. **愉悦体验**: 通过微交互和动画提升使用体验

## 2. 设计系统

### 2.1 颜色系统

```yaml
colors:
  # 原色
  primitive:
    blue:
      50: "#eff6ff"
      100: "#dbeafe"
      200: "#bfdbfe"
      300: "#93c5fd"
      400: "#60a5fa"
      500: "#3b82f6"  # 主色调
      600: "#2563eb"
      700: "#1d4ed8"
      800: "#1e40af"
      900: "#1e3a8a"
    
    gray:
      50: "#f9fafb"
      100: "#f3f4f6"
      200: "#e5e7eb"
      300: "#d1d5db"
      400: "#9ca3af"
      500: "#6b7280"
      600: "#4b5563"
      700: "#374151"
      800: "#1f2937"
      900: "#111827"
    
    green:
      50: "#f0fdf4"
      400: "#4ade80"
      500: "#22c55e"
      600: "#16a34a"
    
    amber:
      50: "#fffbeb"
      400: "#fbbf24"
      500: "#f59e0b"
      600: "#d97706"
    
    red:
      50: "#fef2f2"
      400: "#f87171"
      500: "#ef4444"
      600: "#dc2626"
  
  # 语义化颜色
  semantic:
    primary:
      default: "@blue.500"
      hover: "@blue.600"
      active: "@blue.700"
      light: "@blue.100"
      contrast: "#ffffff"
    
    success:
      default: "@green.500"
      light: "@green.50"
      contrast: "#ffffff"
    
    warning:
      default: "@amber.500"
      light: "@amber.50"
      contrast: "#000000"
    
    danger:
      default: "@red.500"
      light: "@red.50"
      contrast: "#ffffff"
    
    surface:
      background: "#ffffff"
      foreground: "@gray.900"
      secondary: "@gray.50"
      tertiary: "@gray.100"
    
    border:
      default: "@gray.200"
      hover: "@gray.300"
      focus: "@blue.500"
    
    text:
      primary: "@gray.900"
      secondary: "@gray.600"
      tertiary: "@gray.500"
      disabled: "@gray.400"
      inverse: "#ffffff"
```

### 2.2 字体系统

```yaml
typography:
  fonts:
    sans: "'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif"
    mono: "'JetBrains Mono', 'Fira Code', monospace"
  
  scale:
    xs:
      size: "0.75rem"    # 12px
      height: "1rem"     # 16px
      weight: 400
      tracking: "0.05em"
    
    sm:
      size: "0.875rem"   # 14px
      height: "1.25rem"  # 20px
      weight: 400
      tracking: "0.025em"
    
    base:
      size: "1rem"       # 16px
      height: "1.5rem"   # 24px
      weight: 400
      tracking: "0em"
    
    lg:
      size: "1.125rem"   # 18px
      height: "1.75rem"  # 28px
      weight: 400
      tracking: "-0.025em"
    
    xl:
      size: "1.25rem"    # 20px
      height: "1.75rem"  # 28px
      weight: 500
      tracking: "-0.025em"
    
    "2xl":
      size: "1.5rem"     # 24px
      height: "2rem"     # 32px
      weight: 600
      tracking: "-0.05em"
    
    "3xl":
      size: "1.875rem"   # 30px
      height: "2.25rem"  # 36px
      weight: 700
      tracking: "-0.05em"
```

### 2.3 间距系统

```yaml
spacing:
  base: 4  # 4px 基础单位
  scale:
    0: "0px"
    0.5: "2px"
    1: "4px"
    1.5: "6px"
    2: "8px"
    3: "12px"
    4: "16px"
    5: "20px"
    6: "24px"
    8: "32px"
    10: "40px"
    12: "48px"
    16: "64px"
    20: "80px"
```

### 2.4 效果系统

```yaml
effects:
  shadow:
    sm: "0 1px 2px 0 rgb(0 0 0 / 0.05)"
    base: "0 1px 3px 0 rgb(0 0 0 / 0.1), 0 1px 2px -1px rgb(0 0 0 / 0.1)"
    md: "0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)"
    lg: "0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1)"
    xl: "0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1)"
  
  radius:
    none: "0"
    sm: "0.125rem"   # 2px
    base: "0.25rem"  # 4px
    md: "0.375rem"   # 6px
    lg: "0.5rem"     # 8px
    xl: "0.75rem"    # 12px
    "2xl": "1rem"    # 16px
    full: "9999px"
  
  transition:
    fast: "150ms ease-in-out"
    base: "200ms ease-in-out"
    slow: "300ms ease-in-out"
    
  blur:
    sm: "4px"
    base: "8px"
    lg: "16px"
```

## 3. 布局系统

### 3.1 响应式断点

```yaml
breakpoints:
  sm: "640px"   # 手机横屏
  md: "768px"   # 平板竖屏
  lg: "1024px"  # 平板横屏
  xl: "1280px"  # 桌面
  "2xl": "1536px" # 大屏幕
```

### 3.2 网格系统

```yaml
grid:
  columns: 12
  gap:
    default: "@spacing.4"  # 16px
    sm: "@spacing.3"       # 12px
    lg: "@spacing.6"       # 24px
  
  container:
    padding:
      mobile: "@spacing.4"  # 16px
      tablet: "@spacing.6"  # 24px
      desktop: "@spacing.8" # 32px
    
    maxWidth:
      sm: "640px"
      md: "768px"
      lg: "1024px"
      xl: "1280px"
```

### 3.3 主要布局结构

```yaml
layout:
  header:
    height:
      mobile: "56px"
      desktop: "64px"
    zIndex: 50
  
  sidebar:
    width:
      collapsed: "64px"
      expanded: "280px"
    transition: "@transition.base"
  
  main:
    minHeight: "calc(100vh - var(--header-height))"
    padding:
      mobile: "@spacing.4"
      desktop: "@spacing.6"
```

## 4. 核心组件设计

### 4.1 任务卡片组件 (TaskCard)

```yaml
component:
  name: "TaskCard"
  category: "organisms"
  description: "展示单个任务的卡片组件"
  
  anatomy:
    - checkbox: "完成状态复选框"
    - priority_indicator: "优先级指示器"
    - title: "任务标题"
    - description: "任务描述（可选）"
    - tags: "标签列表"
    - due_date: "截止日期"
    - actions: "操作按钮组"
  
  states:
    default:
      background: "@surface.background"
      border: "1px solid @border.default"
      shadow: "@shadow.sm"
    
    hover:
      border: "1px solid @border.hover"
      shadow: "@shadow.base"
      transform: "translateY(-1px)"
    
    completed:
      opacity: 0.7
      title: "line-through"
    
    overdue:
      border: "1px solid @danger.default"
      background: "@danger.light"
  
  variants:
    list:
      padding: "@spacing.4"
      display: "flex"
      gap: "@spacing.3"
    
    grid:
      padding: "@spacing.5"
      display: "flex"
      flexDirection: "column"
      gap: "@spacing.3"
```

### 4.2 优先级指示器 (PriorityIndicator)

```yaml
component:
  name: "PriorityIndicator"
  category: "atoms"
  
  variants:
    high:
      color: "@danger.default"
      icon: "arrow-up"
      label: "高优先级"
    
    medium:
      color: "@warning.default"
      icon: "equals"
      label: "中优先级"
    
    low:
      color: "@primary.default"
      icon: "arrow-down"
      label: "低优先级"
  
  sizes:
    sm:
      width: "16px"
      height: "16px"
    
    md:
      width: "20px"
      height: "20px"
```

### 4.3 标签组件 (Tag)

```yaml
component:
  name: "Tag"
  category: "atoms"
  
  anatomy:
    - dot: "颜色指示点"
    - label: "标签文本"
    - remove: "删除按钮（可选）"
  
  styling:
    base: |
      inline-flex items-center gap-1.5
      px-2 py-0.5 rounded-full
      text-xs font-medium
      transition-all duration-200
    
    interactive: |
      hover:bg-gray-100
      cursor-pointer
    
    removable: |
      pr-1
```

### 4.4 快速添加栏 (QuickAddBar)

```yaml
component:
  name: "QuickAddBar"
  category: "molecules"
  
  anatomy:
    - input: "任务输入框"
    - priority_selector: "优先级选择器"
    - date_picker: "日期选择器"
    - tag_selector: "标签选择器"
    - submit_button: "添加按钮"
  
  behavior:
    - "Enter键快速提交"
    - "支持自然语言输入"
    - "智能解析日期和标签"
    - "历史输入建议"
```

### 4.5 过滤器面板 (FilterPanel)

```yaml
component:
  name: "FilterPanel"
  category: "organisms"
  
  sections:
    status:
      title: "状态"
      options:
        - all: "全部"
        - active: "进行中"
        - completed: "已完成"
    
    priority:
      title: "优先级"
      type: "checkbox"
      options:
        - high: "高"
        - medium: "中"
        - low: "低"
    
    tags:
      title: "标签"
      type: "multi-select"
      searchable: true
    
    date_range:
      title: "日期范围"
      type: "date-range-picker"
```

## 5. 页面设计

### 5.1 主页面布局

```yaml
page:
  name: "MainDashboard"
  
  layout:
    header:
      left:
        - logo: "应用标志"
        - title: "我的待办"
      
      center:
        - search_bar: "全局搜索"
      
      right:
        - view_toggle: "视图切换"
        - theme_toggle: "主题切换"
        - user_menu: "用户菜单"
    
    sidebar:
      sections:
        - navigation: "导航菜单"
        - filters: "过滤器"
        - tags: "标签管理"
        - statistics: "统计信息"
    
    main:
      - quick_add: "快速添加栏"
      - task_list: "任务列表"
      - pagination: "分页控件"
```

### 5.2 视图模式

```yaml
views:
  list:
    description: "列表视图，信息密度高"
    layout: "垂直排列的任务卡片"
    
  grid:
    description: "网格视图，视觉效果好"
    columns:
      mobile: 1
      tablet: 2
      desktop: 3
    
  calendar:
    description: "日历视图，按日期组织"
    features:
      - "月视图/周视图切换"
      - "拖拽调整日期"
      - "快速添加到特定日期"
  
  kanban:
    description: "看板视图，按状态组织"
    columns:
      - todo: "待办"
      - in_progress: "进行中"
      - done: "已完成"
```

## 6. 交互设计

### 6.1 微交互

```yaml
interactions:
  task_complete:
    trigger: "点击复选框"
    animation:
      - "复选框填充动画"
      - "任务卡片淡出"
      - "成功提示音效"
    duration: "300ms"
  
  task_add:
    trigger: "点击添加或按Enter"
    animation:
      - "新任务从上方滑入"
      - "列表平滑下移"
    feedback: "轻微震动反馈（移动端）"
  
  drag_drop:
    trigger: "长按或拖拽手势"
    visual:
      - "卡片轻微放大"
      - "投影增强"
      - "目标区域高亮"
```

### 6.2 加载状态

```yaml
loading_states:
  skeleton:
    description: "初始加载时的骨架屏"
    elements:
      - "任务卡片占位符"
      - "闪烁动画效果"
  
  spinner:
    description: "操作进行中"
    position: "中心或行内"
    size: ["sm", "md", "lg"]
  
  progress:
    description: "批量操作进度"
    type: "线性进度条"
```

### 6.3 空状态

```yaml
empty_states:
  no_tasks:
    illustration: "轻松的插画"
    title: "还没有任务"
    description: "点击上方输入框创建您的第一个任务"
    action: "创建任务"
  
  no_results:
    illustration: "搜索插画"
    title: "没有找到匹配的任务"
    description: "尝试调整筛选条件"
    action: "清除筛选"
```

## 7. 响应式设计

### 7.1 移动端适配

```yaml
mobile:
  navigation:
    type: "bottom_navigation"
    items:
      - home: "首页"
      - add: "添加"
      - calendar: "日历"
      - profile: "我的"
  
  gestures:
    - swipe_right: "标记完成"
    - swipe_left: "显示操作"
    - pull_to_refresh: "刷新列表"
  
  optimizations:
    - "减少动画复杂度"
    - "增大可点击区域"
    - "简化信息展示"
```

### 7.2 平板适配

```yaml
tablet:
  layout:
    - "侧边栏默认展开"
    - "双栏布局选项"
    - "支持键盘快捷键"
  
  interactions:
    - "支持多选操作"
    - "拖放功能增强"
```

## 8. 暗色主题

```yaml
dark_theme:
  colors:
    surface:
      background: "@gray.900"
      secondary: "@gray.800"
      tertiary: "@gray.700"
    
    text:
      primary: "@gray.100"
      secondary: "@gray.400"
      tertiary: "@gray.500"
    
    border:
      default: "@gray.700"
      hover: "@gray.600"
    
    primary:
      default: "@blue.400"
      hover: "@blue.300"
  
  adjustments:
    - "降低对比度避免刺眼"
    - "调整阴影透明度"
    - "优化颜色饱和度"
```

## 9. 无障碍设计

### 9.1 键盘导航

```yaml
keyboard_navigation:
  shortcuts:
    - "Tab": "焦点导航"
    - "Enter": "确认操作"
    - "Space": "切换选中"
    - "Esc": "取消/关闭"
    - "Ctrl+N": "新建任务"
    - "Ctrl+/": "显示快捷键"
  
  focus_indicators:
    - "明显的焦点轮廓"
    - "高对比度"
    - "焦点陷阱处理"
```

### 9.2 屏幕阅读器支持

```yaml
accessibility:
  aria_labels:
    - "所有交互元素都有描述"
    - "状态变化即时通知"
    - "表单错误清晰说明"
  
  semantic_html:
    - "使用正确的标题层级"
    - "表单元素正确关联"
    - "列表结构语义化"
```

## 10. 实现示例

### 10.1 任务卡片实现 (React + TypeScript)

```tsx
interface TaskCardProps {
  task: {
    id: string;
    title: string;
    description?: string;
    completed: boolean;
    priority: 'high' | 'medium' | 'low';
    tags: string[];
    dueDate?: Date;
  };
  onComplete: (id: string) => void;
  onEdit: (id: string) => void;
  onDelete: (id: string) => void;
}

export const TaskCard: React.FC<TaskCardProps> = ({ 
  task, 
  onComplete, 
  onEdit, 
  onDelete 
}) => {
  const priorityColors = {
    high: 'text-red-500',
    medium: 'text-amber-500',
    low: 'text-blue-500'
  };

  const isOverdue = task.dueDate && new Date(task.dueDate) < new Date();

  return (
    <div className={`
      bg-white border rounded-lg p-4
      hover:shadow-md hover:border-gray-300
      transition-all duration-200
      ${task.completed ? 'opacity-70' : ''}
      ${isOverdue && !task.completed ? 'border-red-500 bg-red-50' : 'border-gray-200'}
    `}>
      <div className="flex items-start gap-3">
        <input
          type="checkbox"
          checked={task.completed}
          onChange={() => onComplete(task.id)}
          className="mt-1 w-5 h-5 rounded border-gray-300 
                     text-blue-600 focus:ring-blue-500"
          aria-label={`标记${task.title}为${task.completed ? '未' : '已'}完成`}
        />
        
        <div className="flex-1">
          <div className="flex items-center gap-2 mb-1">
            <PriorityIndicator 
              priority={task.priority} 
              className={priorityColors[task.priority]}
            />
            <h3 className={`
              text-base font-medium text-gray-900
              ${task.completed ? 'line-through' : ''}
            `}>
              {task.title}
            </h3>
          </div>
          
          {task.description && (
            <p className="text-sm text-gray-600 mb-2">
              {task.description}
            </p>
          )}
          
          <div className="flex items-center gap-4 text-sm">
            {task.tags.length > 0 && (
              <div className="flex gap-1">
                {task.tags.map(tag => (
                  <Tag key={tag} label={tag} size="sm" />
                ))}
              </div>
            )}
            
            {task.dueDate && (
              <span className={`
                flex items-center gap-1
                ${isOverdue && !task.completed ? 'text-red-600' : 'text-gray-500'}
              `}>
                <CalendarIcon className="w-4 h-4" />
                {formatDate(task.dueDate)}
              </span>
            )}
          </div>
        </div>
        
        <div className="flex gap-1">
          <IconButton
            icon={<EditIcon />}
            onClick={() => onEdit(task.id)}
            aria-label="编辑任务"
          />
          <IconButton
            icon={<DeleteIcon />}
            onClick={() => onDelete(task.id)}
            aria-label="删除任务"
            variant="danger"
          />
        </div>
      </div>
    </div>
  );
};
```

### 10.2 快速添加栏实现

```tsx
export const QuickAddBar: React.FC = () => {
  const [title, setTitle] = useState('');
  const [priority, setPriority] = useState<Priority>('medium');
  const [dueDate, setDueDate] = useState<Date | null>(null);
  const [tags, setTags] = useState<string[]>([]);

  const handleSubmit = (e: FormEvent) => {
    e.preventDefault();
    if (title.trim()) {
      // 添加任务逻辑
      createTask({
        title: title.trim(),
        priority,
        dueDate,
        tags
      });
      
      // 重置表单
      setTitle('');
      setPriority('medium');
      setDueDate(null);
      setTags([]);
    }
  };

  return (
    <form 
      onSubmit={handleSubmit}
      className="bg-white rounded-lg shadow-sm border border-gray-200 p-4"
    >
      <div className="flex gap-3">
        <input
          type="text"
          value={title}
          onChange={(e) => setTitle(e.target.value)}
          placeholder="添加新任务..."
          className="flex-1 px-3 py-2 border border-gray-300 rounded-md
                     focus:outline-none focus:ring-2 focus:ring-blue-500"
          aria-label="任务标题"
        />
        
        <PrioritySelector
          value={priority}
          onChange={setPriority}
        />
        
        <DatePicker
          value={dueDate}
          onChange={setDueDate}
          placeholder="选择日期"
        />
        
        <TagSelector
          value={tags}
          onChange={setTags}
        />
        
        <button
          type="submit"
          className="px-4 py-2 bg-blue-500 text-white rounded-md
                     hover:bg-blue-600 focus:outline-none focus:ring-2
                     focus:ring-blue-500 focus:ring-offset-2
                     transition-colors duration-200"
          aria-label="添加任务"
        >
          添加
        </button>
      </div>
    </form>
  );
};
```

## 11. 设计交付清单

- [x] 设计系统定义（颜色、字体、间距、效果）
- [x] 核心组件规范
- [x] 页面布局设计
- [x] 交互流程说明
- [x] 响应式设计方案
- [x] 暗色主题设计
- [x] 无障碍设计指南
- [x] 实现代码示例
- [ ] 设计资源文件（Figma/Sketch）
- [ ] 图标库定义
- [ ] 动画细节规范
- [ ] 品牌指南

## 12. 下一步建议

1. **组件库开发**：基于此规范开发完整的组件库
2. **设计验证**：通过用户测试验证设计决策
3. **性能优化**：确保所有动画和交互的流畅性
4. **持续迭代**：根据用户反馈不断优化体验

---

本设计规范为待办事项应用提供了完整的UI/UX指导，确保开发团队能够准确实现设计愿景，创造出优秀的用户体验。
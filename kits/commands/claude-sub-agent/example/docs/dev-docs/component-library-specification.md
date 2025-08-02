# 待办事项应用组件库规范

本文档定义了待办事项应用的完整组件库，包括原子组件、分子组件和有机组件的详细规范。

## 原子组件 (Atoms)

### Button 组件

```yaml
component:
  name: "Button"
  category: "atoms"
  version: "1.0.0"
  
  props:
    variant:
      type: "enum"
      options: ["primary", "secondary", "ghost", "danger"]
      default: "primary"
    
    size:
      type: "enum"
      options: ["sm", "md", "lg"]
      default: "md"
    
    disabled:
      type: "boolean"
      default: false
    
    loading:
      type: "boolean"
      default: false
    
    fullWidth:
      type: "boolean"
      default: false
    
    icon:
      type: "ReactNode"
      optional: true
    
    iconPosition:
      type: "enum"
      options: ["left", "right"]
      default: "left"
    
    onClick:
      type: "function"
      optional: true
  
  implementation:
    react_typescript: |
      ```tsx
      import React from 'react';
      import { clsx } from 'clsx';
      import { Spinner } from './Spinner';
      
      interface ButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
        variant?: 'primary' | 'secondary' | 'ghost' | 'danger';
        size?: 'sm' | 'md' | 'lg';
        disabled?: boolean;
        loading?: boolean;
        fullWidth?: boolean;
        icon?: React.ReactNode;
        iconPosition?: 'left' | 'right';
        children: React.ReactNode;
      }
      
      export const Button: React.FC<ButtonProps> = ({
        variant = 'primary',
        size = 'md',
        disabled = false,
        loading = false,
        fullWidth = false,
        icon,
        iconPosition = 'left',
        children,
        className,
        ...props
      }) => {
        const baseClasses = clsx(
          'inline-flex items-center justify-center',
          'font-medium transition-all duration-200',
          'focus:outline-none focus-visible:ring-2 focus-visible:ring-offset-2',
          'disabled:opacity-60 disabled:cursor-not-allowed',
          fullWidth && 'w-full'
        );
        
        const variantClasses = {
          primary: 'bg-blue-500 text-white hover:bg-blue-600 active:bg-blue-700 focus-visible:ring-blue-500',
          secondary: 'bg-gray-100 text-gray-900 hover:bg-gray-200 active:bg-gray-300 focus-visible:ring-gray-500',
          ghost: 'text-gray-700 hover:bg-gray-100 active:bg-gray-200 focus-visible:ring-gray-500',
          danger: 'bg-red-500 text-white hover:bg-red-600 active:bg-red-700 focus-visible:ring-red-500'
        };
        
        const sizeClasses = {
          sm: 'h-8 px-3 text-sm gap-1.5 rounded-md',
          md: 'h-10 px-4 text-base gap-2 rounded-md',
          lg: 'h-12 px-6 text-lg gap-2.5 rounded-lg'
        };
        
        return (
          <button
            className={clsx(
              baseClasses,
              variantClasses[variant],
              sizeClasses[size],
              className
            )}
            disabled={disabled || loading}
            aria-busy={loading}
            {...props}
          >
            {loading ? (
              <Spinner size={size} />
            ) : (
              <>
                {icon && iconPosition === 'left' && icon}
                {children}
                {icon && iconPosition === 'right' && icon}
              </>
            )}
          </button>
        );
      };
      ```
```

### Input 组件

```yaml
component:
  name: "Input"
  category: "atoms"
  version: "1.0.0"
  
  props:
    type:
      type: "string"
      default: "text"
    
    size:
      type: "enum"
      options: ["sm", "md", "lg"]
      default: "md"
    
    error:
      type: "boolean"
      default: false
    
    disabled:
      type: "boolean"
      default: false
    
    icon:
      type: "ReactNode"
      optional: true
    
    iconPosition:
      type: "enum"
      options: ["left", "right"]
      default: "left"
  
  implementation:
    react_typescript: |
      ```tsx
      import React, { forwardRef } from 'react';
      import { clsx } from 'clsx';
      
      interface InputProps extends React.InputHTMLAttributes<HTMLInputElement> {
        size?: 'sm' | 'md' | 'lg';
        error?: boolean;
        icon?: React.ReactNode;
        iconPosition?: 'left' | 'right';
      }
      
      export const Input = forwardRef<HTMLInputElement, InputProps>(({
        size = 'md',
        error = false,
        icon,
        iconPosition = 'left',
        className,
        disabled,
        ...props
      }, ref) => {
        const sizeClasses = {
          sm: 'h-8 text-sm',
          md: 'h-10 text-base',
          lg: 'h-12 text-lg'
        };
        
        const paddingClasses = {
          sm: icon ? (iconPosition === 'left' ? 'pl-9 pr-3' : 'pl-3 pr-9') : 'px-3',
          md: icon ? (iconPosition === 'left' ? 'pl-10 pr-4' : 'pl-4 pr-10') : 'px-4',
          lg: icon ? (iconPosition === 'left' ? 'pl-12 pr-6' : 'pl-6 pr-12') : 'px-6'
        };
        
        const iconSizeClasses = {
          sm: 'w-4 h-4',
          md: 'w-5 h-5',
          lg: 'w-6 h-6'
        };
        
        const iconPositionClasses = {
          left: 'left-3',
          right: 'right-3'
        };
        
        return (
          <div className="relative">
            {icon && (
              <div className={clsx(
                'absolute top-1/2 -translate-y-1/2 text-gray-500',
                iconSizeClasses[size],
                iconPositionClasses[iconPosition]
              )}>
                {icon}
              </div>
            )}
            <input
              ref={ref}
              className={clsx(
                'w-full rounded-md border transition-colors duration-200',
                'focus:outline-none focus:ring-2 focus:ring-offset-2',
                sizeClasses[size],
                paddingClasses[size],
                error
                  ? 'border-red-300 focus:border-red-500 focus:ring-red-500'
                  : 'border-gray-300 focus:border-blue-500 focus:ring-blue-500',
                disabled && 'bg-gray-50 cursor-not-allowed',
                className
              )}
              disabled={disabled}
              {...props}
            />
          </div>
        );
      });
      
      Input.displayName = 'Input';
      ```
```

### Checkbox 组件

```yaml
component:
  name: "Checkbox"
  category: "atoms"
  version: "1.0.0"
  
  props:
    checked:
      type: "boolean"
      default: false
    
    indeterminate:
      type: "boolean"
      default: false
    
    size:
      type: "enum"
      options: ["sm", "md", "lg"]
      default: "md"
    
    disabled:
      type: "boolean"
      default: false
    
    onChange:
      type: "function"
      optional: true
  
  implementation:
    react_typescript: |
      ```tsx
      import React, { useEffect, useRef } from 'react';
      import { clsx } from 'clsx';
      import { CheckIcon, MinusIcon } from '@heroicons/react/20/solid';
      
      interface CheckboxProps extends Omit<React.InputHTMLAttributes<HTMLInputElement>, 'size' | 'type'> {
        indeterminate?: boolean;
        size?: 'sm' | 'md' | 'lg';
      }
      
      export const Checkbox: React.FC<CheckboxProps> = ({
        indeterminate = false,
        size = 'md',
        className,
        ...props
      }) => {
        const ref = useRef<HTMLInputElement>(null);
        
        useEffect(() => {
          if (ref.current) {
            ref.current.indeterminate = indeterminate;
          }
        }, [indeterminate]);
        
        const sizeClasses = {
          sm: 'w-4 h-4',
          md: 'w-5 h-5',
          lg: 'w-6 h-6'
        };
        
        const iconSizeClasses = {
          sm: 'w-3 h-3',
          md: 'w-4 h-4',
          lg: 'w-5 h-5'
        };
        
        return (
          <div className="relative inline-flex items-center">
            <input
              ref={ref}
              type="checkbox"
              className={clsx(
                'peer appearance-none rounded border-gray-300',
                'text-blue-500 focus:ring-2 focus:ring-blue-500 focus:ring-offset-2',
                'disabled:opacity-50 disabled:cursor-not-allowed',
                'checked:bg-blue-500 checked:border-blue-500',
                'indeterminate:bg-blue-500 indeterminate:border-blue-500',
                sizeClasses[size],
                className
              )}
              {...props}
            />
            <CheckIcon 
              className={clsx(
                'absolute pointer-events-none',
                'text-white opacity-0 peer-checked:opacity-100',
                'transition-opacity duration-200',
                iconSizeClasses[size]
              )}
            />
            {indeterminate && (
              <MinusIcon 
                className={clsx(
                  'absolute pointer-events-none',
                  'text-white',
                  iconSizeClasses[size]
                )}
              />
            )}
          </div>
        );
      };
      ```
```

### Tag 组件

```yaml
component:
  name: "Tag"
  category: "atoms"
  version: "1.0.0"
  
  props:
    label:
      type: "string"
      required: true
    
    color:
      type: "string"
      default: "#3b82f6"
    
    size:
      type: "enum"
      options: ["sm", "md", "lg"]
      default: "md"
    
    removable:
      type: "boolean"
      default: false
    
    onRemove:
      type: "function"
      optional: true
  
  implementation:
    react_typescript: |
      ```tsx
      import React from 'react';
      import { clsx } from 'clsx';
      import { XMarkIcon } from '@heroicons/react/20/solid';
      
      interface TagProps {
        label: string;
        color?: string;
        size?: 'sm' | 'md' | 'lg';
        removable?: boolean;
        onRemove?: () => void;
        onClick?: () => void;
      }
      
      export const Tag: React.FC<TagProps> = ({
        label,
        color = '#3b82f6',
        size = 'md',
        removable = false,
        onRemove,
        onClick
      }) => {
        const sizeClasses = {
          sm: 'px-2 py-0.5 text-xs gap-1',
          md: 'px-2.5 py-1 text-sm gap-1.5',
          lg: 'px-3 py-1.5 text-base gap-2'
        };
        
        const iconSizeClasses = {
          sm: 'w-3 h-3',
          md: 'w-4 h-4',
          lg: 'w-5 h-5'
        };
        
        return (
          <span
            className={clsx(
              'inline-flex items-center rounded-full font-medium',
              'transition-all duration-200',
              onClick && 'cursor-pointer hover:opacity-80',
              sizeClasses[size]
            )}
            style={{
              backgroundColor: `${color}20`,
              color: color
            }}
            onClick={onClick}
          >
            <span
              className="w-2 h-2 rounded-full"
              style={{ backgroundColor: color }}
            />
            <span>{label}</span>
            {removable && (
              <button
                type="button"
                onClick={(e) => {
                  e.stopPropagation();
                  onRemove?.();
                }}
                className={clsx(
                  'ml-0.5 hover:opacity-70 transition-opacity',
                  iconSizeClasses[size]
                )}
                aria-label={`删除标签 ${label}`}
              >
                <XMarkIcon className="w-full h-full" />
              </button>
            )}
          </span>
        );
      };
      ```
```

### IconButton 组件

```yaml
component:
  name: "IconButton"
  category: "atoms"
  version: "1.0.0"
  
  props:
    icon:
      type: "ReactNode"
      required: true
    
    size:
      type: "enum"
      options: ["sm", "md", "lg"]
      default: "md"
    
    variant:
      type: "enum"
      options: ["default", "danger"]
      default: "default"
    
    disabled:
      type: "boolean"
      default: false
  
  implementation:
    react_typescript: |
      ```tsx
      import React from 'react';
      import { clsx } from 'clsx';
      
      interface IconButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
        icon: React.ReactNode;
        size?: 'sm' | 'md' | 'lg';
        variant?: 'default' | 'danger';
      }
      
      export const IconButton: React.FC<IconButtonProps> = ({
        icon,
        size = 'md',
        variant = 'default',
        className,
        ...props
      }) => {
        const sizeClasses = {
          sm: 'w-8 h-8',
          md: 'w-10 h-10',
          lg: 'w-12 h-12'
        };
        
        const variantClasses = {
          default: 'text-gray-500 hover:text-gray-700 hover:bg-gray-100',
          danger: 'text-gray-500 hover:text-red-600 hover:bg-red-50'
        };
        
        return (
          <button
            type="button"
            className={clsx(
              'inline-flex items-center justify-center',
              'rounded-md transition-all duration-200',
              'focus:outline-none focus-visible:ring-2 focus-visible:ring-offset-2',
              'focus-visible:ring-blue-500',
              'disabled:opacity-50 disabled:cursor-not-allowed',
              sizeClasses[size],
              variantClasses[variant],
              className
            )}
            {...props}
          >
            {icon}
          </button>
        );
      };
      ```
```

## 分子组件 (Molecules)

### FormField 组件

```yaml
component:
  name: "FormField"
  category: "molecules"
  version: "1.0.0"
  
  props:
    label:
      type: "string"
      required: true
    
    required:
      type: "boolean"
      default: false
    
    error:
      type: "string"
      optional: true
    
    hint:
      type: "string"
      optional: true
    
    children:
      type: "ReactNode"
      required: true
  
  implementation:
    react_typescript: |
      ```tsx
      import React from 'react';
      import { clsx } from 'clsx';
      
      interface FormFieldProps {
        label: string;
        required?: boolean;
        error?: string;
        hint?: string;
        children: React.ReactNode;
        className?: string;
      }
      
      export const FormField: React.FC<FormFieldProps> = ({
        label,
        required = false,
        error,
        hint,
        children,
        className
      }) => {
        return (
          <div className={clsx('space-y-1', className)}>
            <label className="block text-sm font-medium text-gray-700">
              {label}
              {required && (
                <span className="ml-1 text-red-500" aria-label="必填">
                  *
                </span>
              )}
            </label>
            {children}
            {hint && !error && (
              <p className="text-sm text-gray-500">{hint}</p>
            )}
            {error && (
              <p className="text-sm text-red-600" role="alert">
                {error}
              </p>
            )}
          </div>
        );
      };
      ```
```

### PrioritySelector 组件

```yaml
component:
  name: "PrioritySelector"
  category: "molecules"
  version: "1.0.0"
  
  props:
    value:
      type: "enum"
      options: ["high", "medium", "low"]
      required: true
    
    onChange:
      type: "function"
      required: true
    
    size:
      type: "enum"
      options: ["sm", "md", "lg"]
      default: "md"
  
  implementation:
    react_typescript: |
      ```tsx
      import React from 'react';
      import { clsx } from 'clsx';
      import { 
        ArrowUpIcon, 
        EqualsIcon, 
        ArrowDownIcon 
      } from '@heroicons/react/20/solid';
      
      type Priority = 'high' | 'medium' | 'low';
      
      interface PrioritySelectorProps {
        value: Priority;
        onChange: (priority: Priority) => void;
        size?: 'sm' | 'md' | 'lg';
      }
      
      export const PrioritySelector: React.FC<PrioritySelectorProps> = ({
        value,
        onChange,
        size = 'md'
      }) => {
        const priorities: { value: Priority; icon: React.ReactNode; color: string; label: string }[] = [
          { 
            value: 'high', 
            icon: <ArrowUpIcon />, 
            color: 'text-red-500',
            label: '高优先级'
          },
          { 
            value: 'medium', 
            icon: <EqualsIcon />, 
            color: 'text-amber-500',
            label: '中优先级'
          },
          { 
            value: 'low', 
            icon: <ArrowDownIcon />, 
            color: 'text-blue-500',
            label: '低优先级'
          }
        ];
        
        const sizeClasses = {
          sm: 'h-8 p-1',
          md: 'h-10 p-1.5',
          lg: 'h-12 p-2'
        };
        
        const iconSizeClasses = {
          sm: 'w-4 h-4',
          md: 'w-5 h-5',
          lg: 'w-6 h-6'
        };
        
        return (
          <div 
            className={clsx(
              'inline-flex rounded-md bg-gray-100',
              sizeClasses[size]
            )}
            role="radiogroup"
            aria-label="选择优先级"
          >
            {priorities.map((priority) => (
              <button
                key={priority.value}
                type="button"
                role="radio"
                aria-checked={value === priority.value}
                aria-label={priority.label}
                onClick={() => onChange(priority.value)}
                className={clsx(
                  'inline-flex items-center justify-center',
                  'px-3 rounded transition-all duration-200',
                  iconSizeClasses[size],
                  value === priority.value
                    ? 'bg-white shadow-sm'
                    : 'hover:bg-gray-200',
                  priority.color
                )}
              >
                {priority.icon}
              </button>
            ))}
          </div>
        );
      };
      ```
```

### SearchBar 组件

```yaml
component:
  name: "SearchBar"
  category: "molecules"
  version: "1.0.0"
  
  props:
    value:
      type: "string"
      required: true
    
    onChange:
      type: "function"
      required: true
    
    placeholder:
      type: "string"
      default: "搜索..."
    
    onClear:
      type: "function"
      optional: true
  
  implementation:
    react_typescript: |
      ```tsx
      import React from 'react';
      import { MagnifyingGlassIcon, XMarkIcon } from '@heroicons/react/20/solid';
      import { Input } from './Input';
      import { IconButton } from './IconButton';
      
      interface SearchBarProps {
        value: string;
        onChange: (value: string) => void;
        placeholder?: string;
        onClear?: () => void;
      }
      
      export const SearchBar: React.FC<SearchBarProps> = ({
        value,
        onChange,
        placeholder = '搜索...',
        onClear
      }) => {
        const handleClear = () => {
          onChange('');
          onClear?.();
        };
        
        return (
          <div className="relative">
            <Input
              type="text"
              value={value}
              onChange={(e) => onChange(e.target.value)}
              placeholder={placeholder}
              icon={<MagnifyingGlassIcon />}
              iconPosition="left"
              className="pr-10"
            />
            {value && (
              <div className="absolute right-2 top-1/2 -translate-y-1/2">
                <IconButton
                  icon={<XMarkIcon className="w-4 h-4" />}
                  size="sm"
                  onClick={handleClear}
                  aria-label="清除搜索"
                />
              </div>
            )}
          </div>
        );
      };
      ```
```

## 有机组件 (Organisms)

### TaskCard 组件

```yaml
component:
  name: "TaskCard"
  category: "organisms"
  version: "1.0.0"
  
  props:
    task:
      type: "Task"
      required: true
    
    variant:
      type: "enum"
      options: ["list", "grid"]
      default: "list"
    
    onComplete:
      type: "function"
      required: true
    
    onEdit:
      type: "function"
      required: true
    
    onDelete:
      type: "function"
      required: true
  
  implementation:
    react_typescript: |
      ```tsx
      import React from 'react';
      import { clsx } from 'clsx';
      import { format } from 'date-fns';
      import { zhCN } from 'date-fns/locale';
      import { 
        CalendarIcon, 
        PencilIcon, 
        TrashIcon 
      } from '@heroicons/react/20/solid';
      import { Checkbox } from './Checkbox';
      import { Tag } from './Tag';
      import { IconButton } from './IconButton';
      import { PriorityIndicator } from './PriorityIndicator';
      
      interface Task {
        id: string;
        title: string;
        description?: string;
        completed: boolean;
        priority: 'high' | 'medium' | 'low';
        tags: Array<{ id: string; name: string; color: string }>;
        dueDate?: Date;
        createdAt: Date;
        updatedAt: Date;
      }
      
      interface TaskCardProps {
        task: Task;
        variant?: 'list' | 'grid';
        onComplete: (id: string) => void;
        onEdit: (id: string) => void;
        onDelete: (id: string) => void;
      }
      
      export const TaskCard: React.FC<TaskCardProps> = ({
        task,
        variant = 'list',
        onComplete,
        onEdit,
        onDelete
      }) => {
        const isOverdue = task.dueDate && 
          new Date(task.dueDate) < new Date() && 
          !task.completed;
        
        const cardClasses = clsx(
          'bg-white border rounded-lg transition-all duration-200',
          'hover:shadow-md hover:border-gray-300',
          task.completed && 'opacity-70',
          isOverdue ? 'border-red-300 bg-red-50' : 'border-gray-200',
          variant === 'list' ? 'p-4' : 'p-5'
        );
        
        const contentLayout = variant === 'list' 
          ? 'flex items-start gap-3' 
          : 'space-y-3';
        
        return (
          <div className={cardClasses}>
            <div className={contentLayout}>
              <Checkbox
                checked={task.completed}
                onChange={() => onComplete(task.id)}
                className={variant === 'grid' ? 'mx-auto' : ''}
                aria-label={`标记${task.title}为${task.completed ? '未' : '已'}完成`}
              />
              
              <div className="flex-1 min-w-0">
                <div className="flex items-start justify-between gap-2 mb-1">
                  <div className="flex items-center gap-2">
                    <PriorityIndicator priority={task.priority} />
                    <h3 className={clsx(
                      'text-base font-medium text-gray-900',
                      task.completed && 'line-through'
                    )}>
                      {task.title}
                    </h3>
                  </div>
                  
                  <div className="flex gap-1 shrink-0">
                    <IconButton
                      icon={<PencilIcon className="w-4 h-4" />}
                      size="sm"
                      onClick={() => onEdit(task.id)}
                      aria-label="编辑任务"
                    />
                    <IconButton
                      icon={<TrashIcon className="w-4 h-4" />}
                      size="sm"
                      variant="danger"
                      onClick={() => onDelete(task.id)}
                      aria-label="删除任务"
                    />
                  </div>
                </div>
                
                {task.description && (
                  <p className="text-sm text-gray-600 mb-2 line-clamp-2">
                    {task.description}
                  </p>
                )}
                
                <div className={clsx(
                  'flex items-center gap-4 text-sm',
                  variant === 'grid' && 'flex-col items-start gap-2'
                )}>
                  {task.tags.length > 0 && (
                    <div className="flex flex-wrap gap-1">
                      {task.tags.map(tag => (
                        <Tag
                          key={tag.id}
                          label={tag.name}
                          color={tag.color}
                          size="sm"
                        />
                      ))}
                    </div>
                  )}
                  
                  {task.dueDate && (
                    <span className={clsx(
                      'flex items-center gap-1 shrink-0',
                      isOverdue ? 'text-red-600 font-medium' : 'text-gray-500'
                    )}>
                      <CalendarIcon className="w-4 h-4" />
                      {format(new Date(task.dueDate), 'MM月dd日', { locale: zhCN })}
                    </span>
                  )}
                </div>
              </div>
            </div>
          </div>
        );
      };
      ```
```

### QuickAddBar 组件

```yaml
component:
  name: "QuickAddBar"
  category: "organisms"
  version: "1.0.0"
  
  props:
    onAdd:
      type: "function"
      required: true
    
    defaultPriority:
      type: "enum"
      options: ["high", "medium", "low"]
      default: "medium"
  
  implementation:
    react_typescript: |
      ```tsx
      import React, { useState, FormEvent } from 'react';
      import { PlusIcon } from '@heroicons/react/20/solid';
      import { Input } from './Input';
      import { Button } from './Button';
      import { PrioritySelector } from './PrioritySelector';
      import { DatePicker } from './DatePicker';
      import { TagSelector } from './TagSelector';
      
      interface QuickAddBarProps {
        onAdd: (task: {
          title: string;
          priority: 'high' | 'medium' | 'low';
          dueDate?: Date;
          tags: string[];
        }) => void;
        defaultPriority?: 'high' | 'medium' | 'low';
      }
      
      export const QuickAddBar: React.FC<QuickAddBarProps> = ({
        onAdd,
        defaultPriority = 'medium'
      }) => {
        const [title, setTitle] = useState('');
        const [priority, setPriority] = useState(defaultPriority);
        const [dueDate, setDueDate] = useState<Date | undefined>();
        const [tags, setTags] = useState<string[]>([]);
        const [isExpanded, setIsExpanded] = useState(false);
        
        const handleSubmit = (e: FormEvent) => {
          e.preventDefault();
          
          if (title.trim()) {
            onAdd({
              title: title.trim(),
              priority,
              dueDate,
              tags
            });
            
            // 重置表单
            setTitle('');
            setPriority(defaultPriority);
            setDueDate(undefined);
            setTags([]);
            setIsExpanded(false);
          }
        };
        
        return (
          <form 
            onSubmit={handleSubmit}
            className="bg-white rounded-lg shadow-sm border border-gray-200 p-4"
          >
            <div className="space-y-3">
              <div className="flex gap-3">
                <Input
                  type="text"
                  value={title}
                  onChange={(e) => setTitle(e.target.value)}
                  placeholder="添加新任务..."
                  icon={<PlusIcon />}
                  onFocus={() => setIsExpanded(true)}
                  className="flex-1"
                  aria-label="任务标题"
                />
                
                <Button
                  type="submit"
                  disabled={!title.trim()}
                  aria-label="添加任务"
                >
                  添加
                </Button>
              </div>
              
              {isExpanded && (
                <div className="flex flex-wrap gap-3 pt-2 border-t border-gray-100">
                  <PrioritySelector
                    value={priority}
                    onChange={setPriority}
                  />
                  
                  <DatePicker
                    value={dueDate}
                    onChange={setDueDate}
                    placeholder="选择截止日期"
                  />
                  
                  <TagSelector
                    value={tags}
                    onChange={setTags}
                    placeholder="添加标签"
                  />
                </div>
              )}
            </div>
          </form>
        );
      };
      ```
```

### FilterPanel 组件

```yaml
component:
  name: "FilterPanel"
  category: "organisms"
  version: "1.0.0"
  
  props:
    filters:
      type: "Filters"
      required: true
    
    onChange:
      type: "function"
      required: true
    
    taskCounts:
      type: "object"
      optional: true
  
  implementation:
    react_typescript: |
      ```tsx
      import React from 'react';
      import { clsx } from 'clsx';
      import { Checkbox } from './Checkbox';
      import { RadioGroup } from './RadioGroup';
      import { DateRangePicker } from './DateRangePicker';
      import { TagMultiSelect } from './TagMultiSelect';
      
      interface Filters {
        status: 'all' | 'active' | 'completed';
        priority: ('high' | 'medium' | 'low')[];
        tags: string[];
        dateRange?: {
          start: Date;
          end: Date;
        };
      }
      
      interface TaskCounts {
        all: number;
        active: number;
        completed: number;
        high: number;
        medium: number;
        low: number;
      }
      
      interface FilterPanelProps {
        filters: Filters;
        onChange: (filters: Filters) => void;
        taskCounts?: TaskCounts;
      }
      
      export const FilterPanel: React.FC<FilterPanelProps> = ({
        filters,
        onChange,
        taskCounts
      }) => {
        const statusOptions = [
          { value: 'all', label: '全部', count: taskCounts?.all },
          { value: 'active', label: '进行中', count: taskCounts?.active },
          { value: 'completed', label: '已完成', count: taskCounts?.completed }
        ];
        
        const priorityOptions = [
          { value: 'high', label: '高', count: taskCounts?.high },
          { value: 'medium', label: '中', count: taskCounts?.medium },
          { value: 'low', label: '低', count: taskCounts?.low }
        ];
        
        return (
          <div className="space-y-6 p-4 bg-gray-50 rounded-lg">
            {/* 状态筛选 */}
            <div>
              <h3 className="text-sm font-medium text-gray-900 mb-3">
                任务状态
              </h3>
              <RadioGroup
                value={filters.status}
                onChange={(status) => onChange({ ...filters, status })}
                options={statusOptions.map(option => ({
                  ...option,
                  label: (
                    <span className="flex items-center justify-between w-full">
                      <span>{option.label}</span>
                      {option.count !== undefined && (
                        <span className="text-xs text-gray-500">
                          {option.count}
                        </span>
                      )}
                    </span>
                  )
                }))}
              />
            </div>
            
            {/* 优先级筛选 */}
            <div>
              <h3 className="text-sm font-medium text-gray-900 mb-3">
                优先级
              </h3>
              <div className="space-y-2">
                {priorityOptions.map(option => (
                  <label
                    key={option.value}
                    className="flex items-center justify-between cursor-pointer"
                  >
                    <div className="flex items-center gap-2">
                      <Checkbox
                        checked={filters.priority.includes(option.value)}
                        onChange={(e) => {
                          const newPriority = e.target.checked
                            ? [...filters.priority, option.value]
                            : filters.priority.filter(p => p !== option.value);
                          onChange({ ...filters, priority: newPriority });
                        }}
                      />
                      <span className="text-sm text-gray-700">
                        {option.label}优先级
                      </span>
                    </div>
                    {option.count !== undefined && (
                      <span className="text-xs text-gray-500">
                        {option.count}
                      </span>
                    )}
                  </label>
                ))}
              </div>
            </div>
            
            {/* 标签筛选 */}
            <div>
              <h3 className="text-sm font-medium text-gray-900 mb-3">
                标签
              </h3>
              <TagMultiSelect
                value={filters.tags}
                onChange={(tags) => onChange({ ...filters, tags })}
              />
            </div>
            
            {/* 日期范围筛选 */}
            <div>
              <h3 className="text-sm font-medium text-gray-900 mb-3">
                日期范围
              </h3>
              <DateRangePicker
                value={filters.dateRange}
                onChange={(dateRange) => onChange({ ...filters, dateRange })}
              />
            </div>
            
            {/* 清除筛选 */}
            <button
              type="button"
              onClick={() => onChange({
                status: 'all',
                priority: [],
                tags: [],
                dateRange: undefined
              })}
              className="w-full text-sm text-blue-600 hover:text-blue-700"
            >
              清除所有筛选
            </button>
          </div>
        );
      };
      ```
```

## 主题系统

### 主题配置

```typescript
// theme/theme.config.ts
export const lightTheme = {
  colors: {
    primary: {
      50: '#eff6ff',
      500: '#3b82f6',
      600: '#2563eb',
      700: '#1d4ed8',
    },
    gray: {
      50: '#f9fafb',
      100: '#f3f4f6',
      200: '#e5e7eb',
      300: '#d1d5db',
      400: '#9ca3af',
      500: '#6b7280',
      600: '#4b5563',
      700: '#374151',
      800: '#1f2937',
      900: '#111827',
    },
    background: {
      primary: '#ffffff',
      secondary: '#f9fafb',
      tertiary: '#f3f4f6',
    },
    text: {
      primary: '#111827',
      secondary: '#4b5563',
      tertiary: '#6b7280',
      disabled: '#9ca3af',
    },
    border: {
      default: '#e5e7eb',
      hover: '#d1d5db',
      focus: '#3b82f6',
    },
  },
  shadows: {
    sm: '0 1px 2px 0 rgb(0 0 0 / 0.05)',
    base: '0 1px 3px 0 rgb(0 0 0 / 0.1)',
    md: '0 4px 6px -1px rgb(0 0 0 / 0.1)',
    lg: '0 10px 15px -3px rgb(0 0 0 / 0.1)',
  },
};

export const darkTheme = {
  colors: {
    primary: {
      50: '#1e3a5f',
      500: '#60a5fa',
      600: '#3b82f6',
      700: '#2563eb',
    },
    gray: {
      50: '#18181b',
      100: '#1f2937',
      200: '#374151',
      300: '#4b5563',
      400: '#6b7280',
      500: '#9ca3af',
      600: '#d1d5db',
      700: '#e5e7eb',
      800: '#f3f4f6',
      900: '#f9fafb',
    },
    background: {
      primary: '#09090b',
      secondary: '#18181b',
      tertiary: '#1f2937',
    },
    text: {
      primary: '#f9fafb',
      secondary: '#d1d5db',
      tertiary: '#9ca3af',
      disabled: '#6b7280',
    },
    border: {
      default: '#374151',
      hover: '#4b5563',
      focus: '#60a5fa',
    },
  },
  shadows: {
    sm: '0 1px 2px 0 rgb(0 0 0 / 0.3)',
    base: '0 1px 3px 0 rgb(0 0 0 / 0.4)',
    md: '0 4px 6px -1px rgb(0 0 0 / 0.5)',
    lg: '0 10px 15px -3px rgb(0 0 0 / 0.6)',
  },
};
```

### 主题提供器

```typescript
// theme/ThemeProvider.tsx
import React, { createContext, useContext, useState, useEffect } from 'react';
import { lightTheme, darkTheme } from './theme.config';

type Theme = 'light' | 'dark' | 'system';

interface ThemeContextType {
  theme: Theme;
  resolvedTheme: 'light' | 'dark';
  setTheme: (theme: Theme) => void;
}

const ThemeContext = createContext<ThemeContextType | undefined>(undefined);

export const ThemeProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [theme, setTheme] = useState<Theme>('system');
  const [resolvedTheme, setResolvedTheme] = useState<'light' | 'dark'>('light');

  useEffect(() => {
    const mediaQuery = window.matchMedia('(prefers-color-scheme: dark)');
    
    const updateResolvedTheme = () => {
      if (theme === 'system') {
        setResolvedTheme(mediaQuery.matches ? 'dark' : 'light');
      } else {
        setResolvedTheme(theme as 'light' | 'dark');
      }
    };

    updateResolvedTheme();
    mediaQuery.addEventListener('change', updateResolvedTheme);

    return () => {
      mediaQuery.removeEventListener('change', updateResolvedTheme);
    };
  }, [theme]);

  useEffect(() => {
    document.documentElement.classList.toggle('dark', resolvedTheme === 'dark');
  }, [resolvedTheme]);

  return (
    <ThemeContext.Provider value={{ theme, resolvedTheme, setTheme }}>
      {children}
    </ThemeContext.Provider>
  );
};

export const useTheme = () => {
  const context = useContext(ThemeContext);
  if (!context) {
    throw new Error('useTheme must be used within a ThemeProvider');
  }
  return context;
};
```

## 使用指南

### 1. 安装依赖

```bash
pnpm add clsx date-fns @heroicons/react
pnpm add -D @types/react @types/react-dom
```

### 2. 配置 Tailwind CSS

```javascript
// tailwind.config.js
module.exports = {
  content: [
    "./src/**/*.{js,jsx,ts,tsx}",
  ],
  darkMode: 'class',
  theme: {
    extend: {
      // 使用设计系统中定义的值
    },
  },
  plugins: [],
};
```

### 3. 使用组件

```tsx
import { Button, TaskCard, QuickAddBar } from '@/components';

function App() {
  return (
    <div>
      <QuickAddBar onAdd={handleAddTask} />
      <TaskCard 
        task={myTask} 
        onComplete={handleComplete}
        onEdit={handleEdit}
        onDelete={handleDelete}
      />
      <Button variant="primary" onClick={handleClick}>
        点击我
      </Button>
    </div>
  );
}
```

---

本组件库规范为待办事项应用提供了完整的UI组件定义，确保界面的一致性和可维护性。
openapi: 3.0.0
info:
  title: Todo Application API Specification
  version: 1.0.0
  description: |
    待办事项应用的 API 规范文档。虽然当前版本是纯前端应用，
    但此规范为未来可能的后端服务提供接口设计参考。

servers:
  - url: http://localhost:3000/api/v1
    description: 本地开发服务器
  - url: https://api.todo-app.com/v1
    description: 生产服务器（未来）

tags:
  - name: Todos
    description: 任务相关操作
  - name: Tags
    description: 标签管理
  - name: User
    description: 用户相关操作
  - name: Analytics
    description: 数据分析（未来）

paths:
  /todos:
    get:
      summary: 获取任务列表
      operationId: getTodos
      tags:
        - Todos
      parameters:
        - name: status
          in: query
          description: 任务状态筛选
          schema:
            type: string
            enum: [all, completed, incomplete]
            default: all
        - name: priority
          in: query
          description: 优先级筛选
          schema:
            type: array
            items:
              type: string
              enum: [high, medium, low]
          style: form
          explode: true
        - name: tags
          in: query
          description: 标签筛选
          schema:
            type: array
            items:
              type: string
          style: form
          explode: true
        - name: search
          in: query
          description: 搜索关键词
          schema:
            type: string
        - name: startDate
          in: query
          description: 开始日期
          schema:
            type: string
            format: date
        - name: endDate
          in: query
          description: 结束日期
          schema:
            type: string
            format: date
        - name: page
          in: query
          description: 页码
          schema:
            type: integer
            minimum: 1
            default: 1
        - name: limit
          in: query
          description: 每页数量
          schema:
            type: integer
            minimum: 1
            maximum: 100
            default: 20
        - name: sortBy
          in: query
          description: 排序字段
          schema:
            type: string
            enum: [createdAt, updatedAt, dueDate, priority, title]
            default: createdAt
        - name: sortOrder
          in: query
          description: 排序方向
          schema:
            type: string
            enum: [asc, desc]
            default: desc
      responses:
        200:
          description: 成功返回任务列表
          content:
            application/json:
              schema:
                type: object
                properties:
                  data:
                    type: array
                    items:
                      $ref: '#/components/schemas/Todo'
                  pagination:
                    $ref: '#/components/schemas/Pagination'
                  filters:
                    $ref: '#/components/schemas/AppliedFilters'
        400:
          $ref: '#/components/responses/BadRequest'
        500:
          $ref: '#/components/responses/ServerError'

    post:
      summary: 创建新任务
      operationId: createTodo
      tags:
        - Todos
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/CreateTodoRequest'
      responses:
        201:
          description: 任务创建成功
          content:
            application/json:
              schema:
                type: object
                properties:
                  data:
                    $ref: '#/components/schemas/Todo'
                  message:
                    type: string
                    example: "任务创建成功"
        400:
          $ref: '#/components/responses/BadRequest'
        500:
          $ref: '#/components/responses/ServerError'

  /todos/{todoId}:
    parameters:
      - name: todoId
        in: path
        required: true
        description: 任务ID
        schema:
          type: string
          format: uuid

    get:
      summary: 获取单个任务详情
      operationId: getTodoById
      tags:
        - Todos
      responses:
        200:
          description: 成功返回任务详情
          content:
            application/json:
              schema:
                type: object
                properties:
                  data:
                    $ref: '#/components/schemas/Todo'
        404:
          $ref: '#/components/responses/NotFound'
        500:
          $ref: '#/components/responses/ServerError'

    put:
      summary: 更新任务
      operationId: updateTodo
      tags:
        - Todos
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/UpdateTodoRequest'
      responses:
        200:
          description: 任务更新成功
          content:
            application/json:
              schema:
                type: object
                properties:
                  data:
                    $ref: '#/components/schemas/Todo'
                  message:
                    type: string
                    example: "任务更新成功"
        400:
          $ref: '#/components/responses/BadRequest'
        404:
          $ref: '#/components/responses/NotFound'
        500:
          $ref: '#/components/responses/ServerError'

    delete:
      summary: 删除任务
      operationId: deleteTodo
      tags:
        - Todos
      responses:
        200:
          description: 任务删除成功
          content:
            application/json:
              schema:
                type: object
                properties:
                  message:
                    type: string
                    example: "任务删除成功"
        404:
          $ref: '#/components/responses/NotFound'
        500:
          $ref: '#/components/responses/ServerError'

  /todos/{todoId}/complete:
    post:
      summary: 标记任务为已完成
      operationId: completeTodo
      tags:
        - Todos
      parameters:
        - name: todoId
          in: path
          required: true
          schema:
            type: string
            format: uuid
      responses:
        200:
          description: 任务状态更新成功
          content:
            application/json:
              schema:
                type: object
                properties:
                  data:
                    $ref: '#/components/schemas/Todo'
                  message:
                    type: string
                    example: "任务已标记为完成"
        404:
          $ref: '#/components/responses/NotFound'
        500:
          $ref: '#/components/responses/ServerError'

  /todos/batch:
    post:
      summary: 批量操作任务
      operationId: batchUpdateTodos
      tags:
        - Todos
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/BatchTodoRequest'
      responses:
        200:
          description: 批量操作成功
          content:
            application/json:
              schema:
                type: object
                properties:
                  updated:
                    type: integer
                    description: 更新的任务数量
                  message:
                    type: string
                    example: "批量操作完成"

  /tags:
    get:
      summary: 获取所有标签
      operationId: getTags
      tags:
        - Tags
      responses:
        200:
          description: 成功返回标签列表
          content:
            application/json:
              schema:
                type: object
                properties:
                  data:
                    type: array
                    items:
                      $ref: '#/components/schemas/Tag'
        500:
          $ref: '#/components/responses/ServerError'

    post:
      summary: 创建新标签
      operationId: createTag
      tags:
        - Tags
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/CreateTagRequest'
      responses:
        201:
          description: 标签创建成功
          content:
            application/json:
              schema:
                type: object
                properties:
                  data:
                    $ref: '#/components/schemas/Tag'
                  message:
                    type: string
                    example: "标签创建成功"
        400:
          $ref: '#/components/responses/BadRequest'
        409:
          description: 标签已存在
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Error'

  /tags/{tagId}:
    parameters:
      - name: tagId
        in: path
        required: true
        schema:
          type: string
          format: uuid

    put:
      summary: 更新标签
      operationId: updateTag
      tags:
        - Tags
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/UpdateTagRequest'
      responses:
        200:
          description: 标签更新成功
          content:
            application/json:
              schema:
                type: object
                properties:
                  data:
                    $ref: '#/components/schemas/Tag'
                  message:
                    type: string

    delete:
      summary: 删除标签
      operationId: deleteTag
      tags:
        - Tags
      responses:
        200:
          description: 标签删除成功
          content:
            application/json:
              schema:
                type: object
                properties:
                  message:
                    type: string
                    example: "标签删除成功"

  /user/preferences:
    get:
      summary: 获取用户偏好设置
      operationId: getUserPreferences
      tags:
        - User
      responses:
        200:
          description: 成功返回用户偏好
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/UserPreferences'

    put:
      summary: 更新用户偏好设置
      operationId: updateUserPreferences
      tags:
        - User
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/UserPreferences'
      responses:
        200:
          description: 偏好设置更新成功

  /export:
    get:
      summary: 导出任务数据
      operationId: exportTodos
      tags:
        - Todos
      parameters:
        - name: format
          in: query
          required: true
          schema:
            type: string
            enum: [json, csv, markdown]
      responses:
        200:
          description: 成功导出数据
          content:
            application/json:
              schema:
                type: object
            text/csv:
              schema:
                type: string
            text/markdown:
              schema:
                type: string

  /import:
    post:
      summary: 导入任务数据
      operationId: importTodos
      tags:
        - Todos
      requestBody:
        required: true
        content:
          multipart/form-data:
            schema:
              type: object
              properties:
                file:
                  type: string
                  format: binary
                format:
                  type: string
                  enum: [json, csv]
      responses:
        200:
          description: 数据导入成功
          content:
            application/json:
              schema:
                type: object
                properties:
                  imported:
                    type: integer
                    description: 导入的任务数量
                  failed:
                    type: integer
                    description: 失败的任务数量
                  errors:
                    type: array
                    items:
                      type: string

components:
  schemas:
    Todo:
      type: object
      required:
        - id
        - title
        - completed
        - priority
        - tags
        - createdAt
        - updatedAt
      properties:
        id:
          type: string
          format: uuid
          description: 任务唯一标识符
        title:
          type: string
          description: 任务标题
          maxLength: 200
        description:
          type: string
          description: 任务描述
          maxLength: 1000
        completed:
          type: boolean
          description: 完成状态
          default: false
        priority:
          type: string
          enum: [high, medium, low]
          description: 优先级
          default: medium
        tags:
          type: array
          items:
            type: string
          description: 标签列表
        dueDate:
          type: string
          format: date-time
          description: 到期日期
        createdAt:
          type: string
          format: date-time
          description: 创建时间
        updatedAt:
          type: string
          format: date-time
          description: 更新时间
        completedAt:
          type: string
          format: date-time
          description: 完成时间

    CreateTodoRequest:
      type: object
      required:
        - title
      properties:
        title:
          type: string
          minLength: 1
          maxLength: 200
        description:
          type: string
          maxLength: 1000
        priority:
          type: string
          enum: [high, medium, low]
          default: medium
        tags:
          type: array
          items:
            type: string
        dueDate:
          type: string
          format: date-time

    UpdateTodoRequest:
      type: object
      properties:
        title:
          type: string
          minLength: 1
          maxLength: 200
        description:
          type: string
          maxLength: 1000
        completed:
          type: boolean
        priority:
          type: string
          enum: [high, medium, low]
        tags:
          type: array
          items:
            type: string
        dueDate:
          type: string
          format: date-time

    BatchTodoRequest:
      type: object
      required:
        - todoIds
        - operation
      properties:
        todoIds:
          type: array
          items:
            type: string
            format: uuid
        operation:
          type: string
          enum: [complete, delete, updatePriority, addTags, removeTags]
        data:
          type: object
          description: 操作相关的数据

    Tag:
      type: object
      required:
        - id
        - name
        - color
      properties:
        id:
          type: string
          format: uuid
        name:
          type: string
          maxLength: 50
        color:
          type: string
          pattern: '^#[0-9A-Fa-f]{6}$'
          description: 十六进制颜色值
        count:
          type: integer
          description: 使用该标签的任务数量
          minimum: 0

    CreateTagRequest:
      type: object
      required:
        - name
        - color
      properties:
        name:
          type: string
          minLength: 1
          maxLength: 50
        color:
          type: string
          pattern: '^#[0-9A-Fa-f]{6}$'

    UpdateTagRequest:
      type: object
      properties:
        name:
          type: string
          minLength: 1
          maxLength: 50
        color:
          type: string
          pattern: '^#[0-9A-Fa-f]{6}$'

    UserPreferences:
      type: object
      properties:
        theme:
          type: string
          enum: [light, dark, system]
          default: system
        language:
          type: string
          enum: [zh-CN, en-US]
          default: zh-CN
        defaultPriority:
          type: string
          enum: [high, medium, low]
          default: medium
        defaultView:
          type: string
          enum: [list, grid, calendar]
          default: list
        showCompletedTasks:
          type: boolean
          default: true
        autoDeleteCompleted:
          type: boolean
          default: false
        autoDeleteDays:
          type: integer
          minimum: 1
          maximum: 365
          default: 30

    Pagination:
      type: object
      properties:
        page:
          type: integer
          description: 当前页码
        limit:
          type: integer
          description: 每页数量
        total:
          type: integer
          description: 总数量
        pages:
          type: integer
          description: 总页数

    AppliedFilters:
      type: object
      properties:
        status:
          type: string
        priority:
          type: array
          items:
            type: string
        tags:
          type: array
          items:
            type: string
        dateRange:
          type: object
          properties:
            start:
              type: string
              format: date
            end:
              type: string
              format: date
        search:
          type: string

    Error:
      type: object
      required:
        - code
        - message
      properties:
        code:
          type: string
          description: 错误代码
        message:
          type: string
          description: 错误消息
        details:
          type: object
          description: 错误详情

  responses:
    BadRequest:
      description: 请求参数错误
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/Error'
          example:
            code: "BAD_REQUEST"
            message: "请求参数无效"
            details:
              field: "title"
              reason: "标题不能为空"

    NotFound:
      description: 资源未找到
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/Error'
          example:
            code: "NOT_FOUND"
            message: "任务不存在"

    ServerError:
      description: 服务器内部错误
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/Error'
          example:
            code: "INTERNAL_ERROR"
            message: "服务器内部错误"

  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer
      bearerFormat: JWT

security:
  - bearerAuth: []
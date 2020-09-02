# README

table schema

Userモデル
|  カラム名  |  データ型  |
| ---- | ---- |
|  name  |  string  |
|  email  |  string  |
|  password_digest  |  string  |

Taskモデル
|  カラム名  |  データ型  |
| ---- | ---- |
|  title  |  string  |
|  description  |  text  |
|  status  |  string  |
|  priority  |  integer  |
|  deadline  |  datetime  |
|  user_id  |  integer  |

TaskLabelAttachmentモデル
|  カラム名  |  データ型  |
| ---- | ---- |
|  task_id  |  integer  |
|  label_id  |  integer  |

Labelモデル
|  カラム名  |  データ型  |
| ---- | ---- |
|  label_name  |  integer  |

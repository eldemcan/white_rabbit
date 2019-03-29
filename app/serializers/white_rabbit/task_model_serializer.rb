# frozen_string_literal: true

module WhiteRabbit
  class TaskModelSerializer
    include FastJsonapi::ObjectSerializer
    set_key_transform :camel_lower
    attributes :job_class, :job_id, :interval, :params
  end
end

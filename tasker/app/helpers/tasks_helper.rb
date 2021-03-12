module TasksHelper
    def linked_tag_list(task)
        list = task.tag_list.map do |tag_name|
            link_to(tag_name, searchByTag_task_path(task, tag: tag_name))
        end
        safe_join(list, ", ")
    end
end

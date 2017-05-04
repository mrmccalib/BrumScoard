module MembershipsHelper

    def current_membership
        Membership.find(params[:membership_id])
    end

    def worked_on(user, sprint)
        sprint.story_columns.each do |story_column|
            story_column.stories.each do |story|
                story.tasks.each do |task|
                return true if task.user == @user
                end
            end
        end
        return false
    end
end

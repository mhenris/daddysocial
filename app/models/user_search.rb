class UserSearch < ActiveRecord::Base

  def users
    @users ||= find_users
  end

  private

    def find_users
      User.find(:all, :conditions => conditions)
    end
    
    def minimum_age_conditions
      ["users.birthday <= ?", Integer(age_low).years.ago] unless age_low.blank?
    end
    
    def maximum_age_conditions
      ["users.birthday >= ?", Integer(age_high).years.ago] unless age_high.blank?
    end
    
    def conditions
      [conditions_clauses.join(' AND '), *conditions_options]
    end
    
    def conditions_clauses
      conditions_parts.map { |condition| condition.first }
    end
    
    def conditions_options
      conditions_parts.map { |condition| condition[1..-1] }.flatten
    end
    
    def conditions_parts
      private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
    end

end

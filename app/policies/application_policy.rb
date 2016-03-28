class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def create?
    !user.guest?
  end

  def update?
    user.admin? || record.user == user
  end

  def destroy?
    update?
  end
end

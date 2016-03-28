module Policable
  def createable
    policy.create?
  end

  def editable
    policy.update?
  end

  def deleteable
    policy.destroy?
  end

  private

  def policy
    @policy ||= scope && Pundit::PolicyFinder.new(object).policy.new(scope, object)
  end
end

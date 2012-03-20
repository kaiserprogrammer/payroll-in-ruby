require "minitest/autorun"
require_relative "../change_salaried"
require_relative "../add_hourly_employee"

describe ChangeSalaried do
  it "should an employees payment classification to salaried" do
    empId = 10
    t = AddHourlyEmployee.new(empId, "Bill", "Home", 15.25)
    t.execute

    cst = ChangeSalaried.new(empId, 1500.0)
    cst.execute

    e = PayrollDatabase.get_employee(empId)
    e.wont_be_nil

    pc = e.classification
    pc.wont_be_nil
    pc.must_be_kind_of SalariedClassification
    pc.salary.must_be_close_to 1500.0, 0.001

    ps = e.schedule
    ps.must_be_kind_of MonthlySchedule
  end
end

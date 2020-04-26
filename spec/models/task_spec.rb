require "rails_helper"

RSpec.describe Task, type: :model do
  describe "#toggle_complete!" do
    it "should switch complete to false if it began as true" do
      task = Task.create(complete: true)
      task.toggle_complete!
      expect(task.complete).to eq(false)
    end

    it "should switch complete to true if it began as false" do
      task = Task.create(complete: false)
      task.toggle_complete!
      expect(task.complete).to eq(true)
    end
  end

  describe "#overdue?" do
    it "should return true if the deadline is earlier than now" do
      task = Task.create(deadline: 1.day.ago)
      result = task.overdue?
      expect(result).to eq(true)
    end

    it "should return false if the deadline is later than now" do
      task = Task.create(deadline: 1.day.from_now)
      result = task.overdue?
      expect(result).to eq(false)
    end
  end

  describe "#increment_priority!" do
    it "should increase priority by one" do
      task = Task.create(priority: 3)
      task.increment_priority!
      expect(task.priority).to eq(4)
    end

    it "should not increase past 10" do
      task = Task.create(priority: 10)
      task.increment_priority!
      expect(task.priority).to eq(10)
    end
  end

  describe "#snooze_hour!" do
    it "should push deadline off by one hour" do
      deadline = Time.now
      task = Task.create(deadline: deadline)
      task.snooze_hour!
      expect(task.deadline).to eq(deadline + 1.hour)
    end
  end
end

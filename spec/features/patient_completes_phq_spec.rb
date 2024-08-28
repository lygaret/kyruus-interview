require "rails_helper"

RSpec.feature "A patient checks into the app" do
  scenario "for a scheduled appointment" do
    visit root_path

    click_on "Start check in"

    expect(page).to have_content "Please complete all of the steps on this page"

    click_on "Start PHQ screener"

    expect(page).to have_content("Over the past 2 weeks, how often have you been bothered by any of the following problems?")
    expect(page).to have_content("Little interest or pleasure in doing things?")
    expect(page).to have_content("Feeling down, depressed or hopeless?")

    within :css, "select[data-qid='1']" do
      select "Nearly every day"
    end

    within :css, "select[data-qid='2']" do
      select "More than half the days"
    end

    click_on "Save"

    expect(page).to have_content "According to the PHQ screener"
    expect(page).to have_content "you should complete additional screening."
  end
end

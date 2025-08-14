require "application_system_test_case"

class GossipsTest < ApplicationSystemTestCase
  setup do
    @gossip = gossips(:one)
  end

  test "visiting the index" do
    visit gossips_url
    assert_selector "h1", text: "Gossips"
  end

  test "should create gossip" do
    visit gossips_url
    click_on "New gossip"

    fill_in "Content", with: @gossip.content
    fill_in "Title", with: @gossip.title
    fill_in "User", with: @gossip.user_id
    click_on "Create Gossip"

    assert_text "Gossip was successfully created"
    click_on "Back"
  end

  test "should update Gossip" do
    visit gossip_url(@gossip)
    click_on "Edit this gossip", match: :first

    fill_in "Content", with: @gossip.content
    fill_in "Title", with: @gossip.title
    fill_in "User", with: @gossip.user_id
    click_on "Update Gossip"

    assert_text "Gossip was successfully updated"
    click_on "Back"
  end

  test "should destroy Gossip" do
    visit gossip_url(@gossip)
    click_on "Destroy this gossip", match: :first

    assert_text "Gossip was successfully destroyed"
  end
end

require 'test_helper'

class MutantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mutant = mutants(:one)
  end

  test "should get index" do
    get mutants_url, as: :json
    assert_response :success
  end

  test "should create mutant" do
    assert_difference('Mutant.count') do
      post mutants_url, params: { mutant: { name: @mutant.name } }, as: :json
    end

    assert_response 201
  end

  test "should show mutant" do
    get mutant_url(@mutant), as: :json
    assert_response :success
  end

  test "should update mutant" do
    patch mutant_url(@mutant), params: { mutant: { name: @mutant.name } }, as: :json
    assert_response 200
  end

  test "should destroy mutant" do
    assert_difference('Mutant.count', -1) do
      delete mutant_url(@mutant), as: :json
    end

    assert_response 204
  end
end

require 'test_helper'
require 'pry-byebug'
require 'rspec'

class TeamTest < ActiveSupport::TestCase
  setup do
    @team = Team.new()
  end

  test 'player was created from scraped values' do
    scraped_player = [{name: 'Aaron Rodgers', position: 'QB', team_num: 10}]
    scraped_value = [{name: 'Aaron Rodgers', value: 29}]

    @team.make_players(scraped_player, scraped_value)
    assert_equal @team.player.first.position,
                 'QB'
    assert_equal @team.player.first.team,
                 @team
    assert_equal @team.player.first.name,
                 'Aaron Rodgers'
    assert_equal @team.player.first.value,
                 29
  end

  test 'multiple players are created from scraped values' do
    scraped_players = [{name: 'Aaron Rodgers', position: 'QB', team_num: 10},
                      {name: 'John Cena', position: 'MVP', team_num: 10}]
    scraped_values = [{name: 'John Cena', value: 100},
                     {name: 'Aaron Rodgers', value: 29}]

    @team.make_players(scraped_players, scraped_values)

    assert_equal @team.player.first.name,
                 'Aaron Rodgers'
    assert_equal @team.player.first.value,
                 29
    assert_equal @team.player.second.name,
                 'John Cena'
    assert_equal @team.player.second.value,
                 100
  end

  test 'team should be ordered properly' do
    # Fixtures is something that I will need soon
    league = League.new(number: 4430415, site: 'NFL')
    league.scrape_league

    league.team[1].set_starters
  end

  test 'team should return the proper starters total' do
    league = League.new(number: 4430415, site: 'NFL')
    league.scrape_league

    league.team[1].set_starters
    assert_equal 208, 
                 league.team[1].get_starters_total
  end
end

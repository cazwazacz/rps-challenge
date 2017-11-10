feature 'index' do
  scenario 'visiting index sign up form' do
    visit '/'
    expect(page).to have_content 'Your name:'
  end

  scenario 'enter name and go to play page' do
    sign_in_and_play
    expect(page).to have_content "Hello, Allan"
  end
end

feature 'when signed in' do
  scenario 'shows buttons rock paper scissor' do
    sign_in_and_play
    expect(page).to have_content 'rock paper scissors'
  end
end

feature 'when playing' do

  before(:each) do
    allow_any_instance_of(Array).to receive(:sample).and_return(:scissors)
  end

  scenario 'playing rock and computer playing scissors results in win' do
    sign_in_and_play
    allow(Game).to receive(:random_move).and_return(:scissors)
    click_button('rock')
    expect(page).to have_content 'You won!'
  end

  scenario 'says what the computer played' do
    sign_in_and_play
    allow(Game).to receive(:random_move).and_return(:scissors)
    click_button('rock')
    expect(page).to have_content "Computer's move: scissors"
  end

  scenario 'says win count is 6 when player wins 6 times' do
    sign_in_and_play
    allow(Game).to receive(:random_move).and_return(:scissors)
    6.times { click_button('rock') }
    expect(page).to have_content "Computer's move: scissors"
  end
end
require 'watir'
require 'faker'

options = Selenium::WebDriver::Chrome::Options.new
options.add_argument('--no-sandbox')      # helps avoid crashes on some Windows setups
options.add_argument('--disable-gpu')     # disables GPU acceleration

browser = Watir::Browser.new :chrome, options: options # Luodaan selain

browser.goto 'https://thinking-tester-contact-list.herokuapp.com/' # Mennään testi nettisivulle
puts "Page title: #{browser.title}" # Tulostetaan konsoliin nettisivun otsikko

button = browser.button(value: 'Sign up') # Etsitään Sign Up nappi
button.text == 'Sign up' # Jos napin teksti on "Sign Up"
button.click # Painetaan nappia

sleep 2 # Odotetaan 2 sekunttia

# Asetetaan tekstikenttiin meidän tiedot
text_field = browser.text_field(id: 'firstName')
text_field.set 'Julius'
text_field = browser.text_field(id: 'lastName')
text_field.set 'Muurinen'
random_email = Faker::Internet.email # Luodaan random sähköpostiosoite Fakerilla
text_field = browser.text_field(id: 'email')
text_field.set random_email
text_field = browser.text_field(id: 'password')
text_field.set '123Testi321'

button = browser.button(value: 'Submit') # Lähetetään meidän lomake
button.text == 'Submit'
button.click

sleep 2 # Odotetaan 2 sekunttia

button = browser.button(value: 'Logout') # Kirjaudutaan sivulta ulos
button.text == 'Logout'
button.click

sleep 1

# Kirjaudutaan takaisin sisälle
text_field = browser.text_field(id: 'email')
text_field.set random_email
text_field = browser.text_field(id: 'password')
text_field.set '123Testi321'
button = browser.button(value: 'Submit') 
button.text == 'Submit'
button.click

# Odotetaan 3 sekunttia ja suljetaan selain
sleep 3
browser.close
#tester starts at 
# https://devbymany.com/


test(id: 99690, title: "End to End Complete") do
  # You can use any of the following variables in your code:
  # - []
  Capybara.register_driver :sauce do |app|
    @desired_cap = {
      'platform': "Windows 7",
      'browserName': "firefox",
      'version': "45",
      'screenResolution': "1920x1080",
      'name': "bbm_end_to_end_complete",
    }
    Capybara::Selenium::Driver.new(app,
      :browser => :remote,
      :url => 'http://RFAutomation:5328f84f-5623-41ba-a81e-b5daff615024@ondemand.saucelabs.com:80/wd/hub',
      :desired_capabilities => @desired_cap
    )
  end

  rand_num=Random.rand(899999999) + 100000000
  main_pet_input_list = [['Cat','Enya','Pedigree','White Shorthair','Current Year -5','Female','Has Not','Has Not','2360','WN','Moneyback'],
                    ['Cat','Cappuccino','Cross Breed','Wiener Cat','Current Year -6','Male','Has Not','Has','2370','WR','Regular'],
                    ['Dog','Elvis','Pedigree','Aberdeen Terrier','Current Year -7','Male','Has Not','Has Not','2380','AL','Complete']]
  main_pet_input = main_pet_input_list.sample
  reg_cover_input_list = [['No Excess','Add This Option','Add This Option','Add This Option','Today'],
                          ['Excess of £69 plus 20% of claims','Add This Option','Add This Option','leave as is','Today +2']]                  
  reg_cover_input = reg_cover_input_list.sample
  monthly_pay_input_list = [['Monthly','Successful RF','55779911','200000'],
                                ['Monthly','Penniless RF','55779911','200000']]
  monthly_pay_input = monthly_pay_input_list.sample
  fixed_cover_input_list = [['Current Year','Excess of £69 plus 0% of claims'],
                            ['Current Year -1','Excess of £69 plus 20% of claims']]
  fixed_cover_input = fixed_cover_input_list.sample
  rand_fName = ('a'..'z').to_a.shuffle[0,8].join
  rand_lName = ('a'..'z').to_a.shuffle[0,8].join

  window = Capybara.current_session.driver.browser.manage.window
  #window.maximize

  step id: 1,
      action: "If you {{Main_Pet_Input.pet_breed}} see a browser pop up asking for username and password enter username: '' and password: ''. Click login or OK.",
      response: "Do you see the main page with the logo Bought By Many in the top left?" do
    # *** START EDITING HERE ***

    # action
    visit "https://stagingbymany.com/"

    # response
    expect(page).to have_selector(:css, 'span', :text => 'Bought By Many', :match => :first)

    #page.save_screenshot('screenshot_step_1.png')
    # *** STOP EDITING HERE ***
  end

  step id: 2,
      action: "Click on the Get Quote Button in the Centre of the Page",
      response: "Were you redirected to the Registration Page?" do
    # *** START EDITING HERE ***

    # action
    scroll_offset = 500 
    page.execute_script("window.scrollTo(0,#{scroll_offset})")
    within(:css, '.policy:nth-child(2)') do
      page.find(:css, 'a', :text => 'Get a quote', wait: 40).click
    end

    # response
    expect(page).to have_content('Registration')
    #page.save_screenshot('screenshot_step_2.png')
    # *** STOP EDITING HERE ***
  end

  step id: 3,
      action: "Enter email address: '{{random.email}}', First Name: '{{random.first_name}}' and Last Name: '{{random.last_name}}” in"\
              " First & Last Name box. Click Next. If the email address is already taken use '123{{random.email}}'.",
      response: "Were you redirect automatically to the Password Page?" do
   
    # *** START EDITING HERE ***

    # action
    page.fill_in 'email', with: rand_fName+'_'+rand_lName+'@nowhere.com'
    page.fill_in 'full_name', with: rand_fName + ' ' + rand_lName
    page.click_link_or_button('Next ›')

    # response
    expect(page).to have_content('Your password')
  
    #page.save_screenshot('screenshot_step_3.png')
    # *** STOP EDITING HERE ***
  end

  step id: 4,
      action: "Enter Password: '{{random.password}}' and Confirm Password: '{{random.password}}' Fields. Click Complete Registration Button.",
      response: "Were you redirected to the Get Your Quote Page with a 'Let's get started' button in Green? If you see a pop up in the"\
                "bottom right corner, close this out." do
    
    # *** START EDITING HERE ***

    # action
    page.fill_in 'password1', with: 'Pass1212'
    page.fill_in 'password2', with: 'Pass1212'
    page.click_link_or_button('Complete Registration')

    # response
    expect(page).to have_content('Get your quote', wait: 60)

    #page.save_screenshot('screenshot_step_4.png')
    # *** STOP EDITING HERE ***
  end

  step id: 5,
      action: "Click on the green button 'Let's get started'.",
      response: "Do you see 'I have a dog called _' on the page?" do
   
    # *** START EDITING HERE ***
     
    # action
    within(:css, '.splash.fullheight') do
      page.find(:css, "a[class='btn']", :text => "Let's get started").click
    end

    # response
    expect(page).to have_content('I have a')

    #page.save_screenshot('screenshot_step_5.png')
    # *** STOP EDITING HERE ***
  end

  step id: 6,
      action: "Click on dog. Then click on {{Main_Pet_Input.pet_type}}.",
      response: "Does the sentence now show {{Main_Pet_Input.pet_type}} in the field?" do      
    # *** START EDITING HERE ***
      
    # action
    page.find(:css, 'a', :text => 'dog').click
    expect(page).to have_content('What type of pet do you have?')
    page.find(:css, 'label', :text => main_pet_input[0]).click

    # response
    expect(page).to have_selector(:css, '.mutt-natural-trigger.mutt-natural-completed', :text => main_pet_input[0].downcase) 


    #page.save_screenshot('screenshot_step_6.png')
    # *** STOP EDITING HERE ***

  end
  
  
 step id: 7,
      action: "Click on the green dots at the end of the sentence.",
      response: "Do you see 'What is your pet's name?'?" do
    # *** START EDITING HERE ***

    # action
    within(:css, '#insured_entities_1_pet_name') do
      page.find(:css, '.mutt-natural-trigger').click
    end

    # response
    expect(page).to have_content("What is your pet's name?")
    
    #page.save_screenshot('screenshot_step_7.png')
    # *** STOP EDITING HERE ***

  end

  step id: 8,
      action: "Enter '{{Main_Pet_Input.pet_name}}' in the field. Click on the green button 'Done'.",
      response: "Do you see 'I have a {{Main_Pet_Input.pet_type}} called {{Main_Pet_Input.pet_name}}'?" do
    # *** START EDITING HERE ***
    
    # action
    page.fill_in 'pet_name', with: main_pet_input[1]
    page.click_link_or_button('Done')

    # response
    expect(page).to have_content('I have a')
    expect(page).to have_content(main_pet_input[1])

    #page.save_screenshot('screenshot_step_8.png')
    # *** STOP EDITING HERE ***

  end
  
  step id: 9,
      action: "There is a text '{{Main_Pet_Input.pet_name}} is a _ and was born on _' where two words are replaced with dots."\
              " Click on the first set of dots.",
      response: "Do you see 'What type of breed is it' OR 'Type of breed?' (ON MOBILE) with three breed type choices separated"\
              " in individual green boxes?" do

    # *** START EDITING HERE ***

     # action
    within(:css, '#insured_entities_1_breed') do
      page.find(:css, '.mutt-natural-trigger').click
    end
     
    # response
    expect(page).to have_content('What type of breed is it')

    #page.save_screenshot('screenshot_step_9.png')
    # *** STOP EDITING HERE ***

  end

  
  step id: 10,
      action: "Click {{Main_Pet_Input.breed_variant}}.",
      response: "Do you see a checkmark next to {{Main_Pet_Input.breed_variant}} ?" do

    # *** START EDITING HERE ***

    # action
    page.find(:css, 'label', :text => main_pet_input[2]).click

    # response
    expect(page).to have_no_content('What type of breed is it')
    expect(page).to have_no_selector(:css, 'mutt-help>h6')
    #sleep(5)
    #expect(page.has_checked_field?(main_pet_input[2])).to eql(true)
    
    
    #page.save_screenshot('screenshot_step_10.png')
    # *** STOP EDITING HERE ***

  end

  step id: 11,
      action: "In the text field under the breeds, enter '{{Main_Pet_Input.pet_breed}}' and choose '{{Main_Pet_Input.pet_breed}}' "\
              "from the dropdown if needed. Click the green 'Done' button below",
      response: "On the page (could be the second line), do you see a text starting with '{{Main_Pet_Input.pet_name}} is a "\
                "{{Main_Pet_Input.pet_breed}} and was born on ___'?" do
   
    # *** START EDITING HERE ***

    # action
    within(:css, '#insured_entities_1_breed') do
      page.find(:css, '.mutt-natural-autocomplete').click
      for x in 0..main_pet_input[3].length do
        page.find(:css, "input[placeholder='Enter the breed e.g. Pug']").send_keys(main_pet_input[3][x])
      end
      within(:css, '.mutt-autocomplete-dropdown__list', wait: 30) do
        expect(page).to have_content(main_pet_input[3])
      end
      sleep(1)
      page.find(:css, 'li', :text => main_pet_input[3], :match => :first).hover
      page.find(:css, 'li', :text => main_pet_input[3], :match => :first).click
      expect(page).to have_no_selector(:css, 'li', :text => main_pet_input[3])
      page.click_link_or_button('Done')
    end

    # response
    expect(page).to have_content(main_pet_input[1] + ' is a ' + main_pet_input[3])


    #page.save_screenshot('screenshot_step_11.png')
    # *** STOP EDITING HERE ***

  end
  
  step id: 12,
      action: "Click on the green dots at the end of the sentence.",
      response: "Do you see 'When was your pet born?'?" do

    # *** START EDITING HERE ***

    # action
    within(:css, '#insured_entities_1_dob') do
      page.find(:css, '.mutt-natural-trigger').click
    end

    # response
    expect(page).to have_content('When was your pet born?')

    #page.save_screenshot('screenshot_step_12.png')
    # *** STOP EDITING HERE ***
  end

    step id: 13,
      action: "Choose and any day and any month with {{Main_Pet_Input.pet_dob_year}}. Click 'Done'.?",
      response: "On the page (could be the second line), do you see '{{Main_Pet_Input.pet_name}} is a {{Main_Pet_Input.pet_breed}}"\
                " and was born on ___ '?" do

    # *** START EDITING HERE ***
    day = Random.rand(1...28).to_s
    month = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'].sample
    year_input = main_pet_input[4].split(' ')
    year = (2017 + year_input[-1].to_i).to_s

    # action
    within(:css, '#insured_entities_1_dob') do
      page.select day, :from => 'dob-day'
      sleep(1)
      page.select month, :from => 'dob-month'
      sleep(1)
      page.select year, :from => 'dob-year'
      page.click_link_or_button('Done')
    end

    # response
    expect(page).to have_content(month + ' ' + year)

    #page.save_screenshot('screenshot_step_13.png')
    # *** STOP EDITING HERE ***
  end

    step id: 14,
      action: "Click on the green dots after '{{Main_Pet_Input.pet_name}} is'.",
      response: "Do you see 'What gender is your pet?'?" do

    # *** START EDITING HERE ***

    # action
    within(:css, '#insured_entities_1_gender') do
      page.find(:css, '.mutt-natural-trigger').click
    end

    # response
    expect(page).to have_content('What gender is your pet?')

    #page.save_screenshot('screenshot_step_14.png')
    # *** STOP EDITING HERE ***
  end

    step id: 15,
      action: "Click on '{{Main_Pet_Input.gender}}'.",
      response: "Do you see '{{Main_Pet_Input.pet_name}} is {{Main_Pet_Input.gender}} and _' ?" do

    # *** START EDITING HERE ***

    # action
    page.find(:css, 'label', :text => main_pet_input[5]).click

    # response
    expect(page).to have_content(main_pet_input[1] + ' is ' + main_pet_input[5].downcase)

    #page.save_screenshot('screenshot_step_15.png')
    # *** STOP EDITING HERE ***
  end

    step id: 16,
      action: "Click on the green dots after '{{Main_Pet_Input.pet_name}} is {{Main_Pet_Input.gender}} and ____ '. Then, on the next"\
              " screen choose that your pet {{Main_Pet_Input.pet_health_issues}} health issues in the last two years.",
      response: "Do you see '{{Main_Pet_Input.pet_name}} is {{Main_Pet_Input.gender}} and {{Main_Pet_Input.pet_health_issues}} had "\
                "health issues in the last two years.'?" do

    # *** START EDITING HERE ***

    # action
    within(:css, '#insured_entities_1_healthy') do
      page.find(:css, '.mutt-natural-trigger').click
    end
    expect(page).to have_content('Has your pet had any health issues in the last two years?')
    within(:css, '.mutt-natural-modal-inner>div') do
      page.find(:css, 'label', :text => main_pet_input[6], :match => :first).click
    end

    # response
    expect(page).to have_content(main_pet_input[1] + ' is ' + main_pet_input[5].downcase + ' and ' + main_pet_input[6].downcase)

    #page.save_screenshot('screenshot_step_16.png')
    # *** STOP EDITING HERE ***
  end

    step id: 17,
      action: "Click on the green dots after {{Main_Pet_Input.pet_name}}. On the next screen choose that your pet "\
              "{{Main_Pet_Input.sprayed}} been spayed or neutered.",
      response: "Do you see '{{Main_Pet_Input.pet_name}} {{Main_Pet_Input.sprayed}} been spayed or neutered.'?" do

    # *** START EDITING HERE ***

    # action
    within(:css, '#insured_entities_1_spayed_neutered') do
      page.find(:css, '.mutt-natural-trigger').click
      expect(page).to have_content('Has your pet been spayed or neutered?')
      within(:css, '.mutt-natural-modal-inner>div') do
        page.find(:css, 'label', :text => main_pet_input[7], :match => :first).click
      end
    end

    # response
    expect(page).to have_content(main_pet_input[1] + ' ' + main_pet_input[7].downcase + ' been spayed')

    #page.save_screenshot('screenshot_step_17.png')
    # *** STOP EDITING HERE ***
  end

    step id: 18,
      action: "Click on the green dots in the next sentence and fill {{Main_Pet_Input.pet_price}}. Click on done. Then click on the"\
              " green dots next to 'who lives at _.' In the field enter {{Main_Pet_Input.pet_postcode_prefix}} and choose any address from the dropdown.",
      response: "Did you choose an address from the dropdown and do you see the 'Done' button under?" do

    # *** START EDITING HERE ***

    # action
    within(:css, '#insured_entities_1_value') do
      page.find(:css, '.mutt-natural-trigger').click
    end
    expect(page).to have_content('How much did you pay for your pet?')
    page.fill_in 'value', with: main_pet_input[8]
    page.click_link_or_button('Done')
    expect(page).to have_content('I paid £' + main_pet_input[8])
    within(:css, '#insured_entities_1_pet_address_postcode') do
      page.find(:css, '.mutt-natural-trigger').click
    end
    expect(page).to have_content('Where does your pet live?')
    
    page.find(:css, "input[name='place-of-residence-search']").send_keys(main_pet_input[9][0])
    expect(page).to have_selector(:css, '.pcaitem.pcaexpandable')
    expect(page).to have_content(main_pet_input[9][0])
    page.find(:css, "input[name='place-of-residence-search']").send_keys(main_pet_input[9][1])
    expect(page).to have_content(main_pet_input[9])
    within(:css, '.pca', :match => :first, wait: 60) do
      expect(page).to have_content(main_pet_input[9])
      suburb_list = page.all(:css, '.pcadescription', :minimum => 2, wait: 15)
      suburb = suburb_list.sample
      suburb.hover
      suburb.click
      address_list = page.all(:css, "div[class*='pcaitem'][title^='#{main_pet_input[9]}']", :minimum => 1, wait: 15)
      address = address_list[0..6].sample
      address.hover
      address.click
    end

    # response
    expect(page).to have_no_selector(:css, "div[class*='pcaitem'][title^='#{main_pet_input[9]}']")
    expect(page).to have_selector(:css, 'button', :text => 'Done')
    

    #page.save_screenshot('screenshot_step_18.png')
    # *** STOP EDITING HERE ***
  end

    step id: 19,
      action: "Click 'Done'. This step is different based on if you are on WEB or MOBILE VM. FOR WEB - click on dog.jpg to download "\
              "an image. You may be redirected to a new page and see a pop up at the bottom to SAVE the image. If so click SAVE "\
              "screenshot.png. Click on the camera icon screenshot.png. Choose the picture you selected and allow it to Open. "\
              "FOR MOBILE - click on the camera icon screenshot.png . Choose Documents OR Photo Library (whichever is present). Pick "\
              "any image.",
      response: "Did the photo upload and is it visible on page?" do

    # *** START EDITING HERE ***
    #file_path = Dir.pwd + '/' + main_pet_input[0] + '.jpg'

    # action
    within(:css, '#insured_entities_1_pet_address_postcode') do
      page.click_link_or_button('Done', wait: 30)
    end
    expect(page).to have_content('I paid £' + main_pet_input[8])
    #Capybara.ignore_hidden_elements = false

    #page.execute_script("$('.upload__button.file-input-button-0').show();")
    #page.execute_script("$('.upload__button.file-input-button-0').trigger('change');")
    #page.find(:css, '.upload__button.file-input-button-0').trigger('change')
    
    #page.execute_script("$('.upload__hidden file-input-0').style.display = 'block';")
    #el = page.find(:css, "input[name='file0']", :visible => false)
    #el.send_keys(file_path)
    #page.attach_file('file0', file_path)
    #page.find(:css, "input[name='file0']", :visible => false).send_keys(file_path)
    #Capybara.ignore_hidden_elements = true

    #upload_dialog = webdriver.switch_to_active_element()
    #page.find(:css, '.upload__button.file-input-button-0').send_keys(:escape)
    

  

    # response
    expect(page).to have_content('I paid £' + main_pet_input[8])
    #expect(page).to have_selector(:css, '.upload__button.file-input-button-0.upload__button--complete', wait: 60)

    #page.save_screenshot('screenshot_step_19.png')
    # *** STOP EDITING HERE ***
  end

    step id: 20,
      action: "Click on the Continue Button",
      response: "Does the Loading Page 'We're getting your quotes' appear followed by a page titled Policies for {{Main_Pet_Input.pet_name}}?" do

    # *** START EDITING HERE ***

    # action
    page.click_link_or_button('Continue')

    # response
    expect(page).to have_content("We're getting your quotes")
    expect(page).to have_content('Policies for ' + main_pet_input[1], wait: 90)

    #page.save_screenshot('screenshot_step_20.png')
    # *** STOP EDITING HERE ***
  end

    step id: 21,
      action: "Look at the Policy Options page.",
      response: "Do you see policy option screen with prices for potential policies?" do

    # *** START EDITING HERE ***

    # action
      # no action

    # response
    expect(page).to have_content('Regular')
    expect(page).to have_content('Complete')
    expect(page.all(:css, "div[class*='policy-order']").count).to eql(3)

    #page.save_screenshot('screenshot_step_21.png')
    # *** STOP EDITING HERE ***
  end

    step id: 22,
      action: "View Page 'Policies for {{Main_Pet_Input.pet_name}}'. Scroll down and select the 'Show me all policies' button",
      response: "Has the 'Show me all policies' button disappeared and are the polices all now available on the page?" do

    # *** START EDITING HERE ***

    # action
    page.click_link_or_button('Show me all policies')
     
    # response
    expect(page).to have_no_selector(:css, 'button', :text => 'Show me all policies')
    expect(page).to have_content('Regular')
    expect(page).to have_content('Complete')
    page.all(:css, 'button', :text => 'Select', :minimum => 4)
    
    #page.save_screenshot('screenshot_step_22.png')
    # *** STOP EDITING HERE ***
  end

    step id: 23,
      action: "Look for the 'Complete' policy. Click on the option for {{Fixed_Cover.excess}}. Click Select.",
      response: "Are you taken to a page with Personal Details Name Fields?" do

    # *** START EDITING HERE ***

    # action
    within(:css, '.product-option.flow', :text => 'Complete') do
      page.choose(fixed_cover_input[1])
      page.click_link_or_button('Select')
    end

    # response
    expect(page).to have_content('Personal details')


    #page.save_screenshot('screenshot_step_23.png')
    # *** STOP EDITING HERE ***
  end

    step id: 25,
      action: "Click on the empty fields next to My name is and fill in the fields. For my date of birth is - select a year BEFORE 1998."\
              " For my phone number is, enter 111{{random.phone_number}}. Select Continue",
      response: "Do you see the policy Summary Page?" do

    # *** START EDITING HERE ***
    day = Random.rand(1...28).to_s
    month = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'].sample
    year = (2017 - Random.rand(20...58)).to_s
    telephone = '111' + Random.rand(10000000..99999999).to_s

    # action
    within(:css, '#policy_holders_1_title') do
      page.find(:css, '.mutt-natural-trigger').click
    end
    expect(page).to have_content('Title')
    page.find(:css, 'label', :text => 'Mrs').click
    expect(page).to have_content('My name is Mrs')
    within(:css, '#policy_holders_1_first_name') do
      page.find(:css, '.mutt-natural-trigger').click
    end
    expect(page).to have_content('First Name')
    page.fill_in 'first_name', with: rand_fName
    page.click_link_or_button('Done')
    expect(page).to have_content('My name is Mrs ' + rand_fName.capitalize)
    within(:css, '#policy_holders_1_last_name') do
      page.find(:css, '.mutt-natural-trigger').click
    end
    expect(page).to have_content('Last Name')
    page.fill_in 'last_name', with: rand_lName
    page.click_link_or_button('Done')
    expect(page).to have_content('My name is Mrs ' + rand_fName.capitalize + ' ' + rand_lName.capitalize)
    within(:css, '#policy_holders_1_dob') do
      page.find(:css, '.mutt-natural-trigger').click
    end
    within(:css, '#policy_holders_1_dob') do
      page.select day, :from => 'dob-day'
      page.select month, :from => 'dob-month'
      page.select year, :from => 'dob-year'
      page.click_link_or_button('Done')
    end
    expect(page).to have_content(month + ' ' + year)
    within(:css, '#policy_holders_1_telephone') do
      page.find(:css, '.mutt-natural-trigger').click
    end
    expect(page).to have_content('Telephone')
    page.fill_in 'telephone', with: telephone
    page.click_link_or_button('Done')
    expect(page).to have_content('My phone number is ' + telephone)
    page.click_link_or_button('Continue')

    # response
    expect(page).to have_content('Summary')
    expect(page).to have_content(main_pet_input[1] + "'s policy")
    

    #page.save_screenshot('screenshot_step_25.png')
    # *** STOP EDITING HERE ***
  end


    step id: 28,
      action: "Scroll down. Select the policy start date as Tomorrow. Click Continue. Scroll down and click on the button for I"\
              " agree to Terms and Conditions. Click I Agree.",
      response: "Do you see the Payment Options screen?" do

    # *** START EDITING HERE ***

    # action
    page.click_link_or_button('Tomorrow')
    expect(page).to have_selector(:css, '.btn.btn--secondary.btn--selected', :text => 'Tomorrow')
    page.click_link_or_button('Continue')
    expect(page).to have_content('I agree to the terms and conditions')
    page.find(:css, '.mutt-label').click
    expect(page).to have_selector(:css, ".mutt-label.mutt-field-checkbox-checked")
    page.click_link_or_button('I Agree')

    # response
    expect(page).to have_content('Payment')
    

    #page.save_screenshot('screenshot_step_28.png')
    # *** STOP EDITING HERE ***
  end

    step id: 29,
      action: "Select {{Monthly_Payment.method}} (this may already be selected). Scroll down and enter Account Name:"\
              " {{Monthly_Payment.account_name}}, Account Number: {{Monthly_Payment.account_number}}, Sort Code: {{Monthly_Payment.sort_code}}."\
              " Scroll down and click Continue and pay.",
      response: "Did the 'We are creating your policy' page appear followed by a redirect to a page that says Check Your Email ?" do

    # *** START EDITING HERE ***

    # action
    expect(page).to have_no_selector(:css, '#rotatingAnimationWrapper', wait: 60)
    if !page.has_selector?(:css, '.btn.btn--secondary.btn--selected', :text => 'Monthly')
      page.click_link_or_button('Monthly')
    end
    page.fill_in 'direct_debit_account_name', with: monthly_pay_input[1]
    page.fill_in 'direct_debit_account_number', with: monthly_pay_input[2]
    page.fill_in 'direct_debit_sort_code', with: monthly_pay_input[3]
    page.click_link_or_button('Continue and pay')

    # response
    expect(page).to have_content('We are creating your policy')
    expect(page).to have_content('Check your email', wait: 60)

    #page.save_screenshot('screenshot_step_29.png')
    # *** STOP EDITING HERE ***
  end

  sleep(10)
end

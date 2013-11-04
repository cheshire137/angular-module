describe "E2E: Testing Controllers", ->
  beforeEach ->
    browser().navigateTo "/"

  it "should be able to log in and out", ->
    login()
    logout()

#  it "should be able to start, broadcast, and stop stream", ->
##    login()
##    element('#start-local-video').click()


login = ->
  browser().navigateTo "#/"
  expect(browser().location().path()).toBe "/"
  expect(element('#user_email').html()).toBeDefined()
  element('#user_email').val('jonrowlands83@gmail.com')
  element('#user_password').val('cyberwell')
  element('#sign-in').click()
  sleep(2)
  browser().navigateTo "/"
  expect(element('#sign-out').text()).toBe("Sign out")

logout = ->
  browser().navigateTo "/"
  element('#sign-out').click()
  sleep(2)
  browser().navigateTo "/"
  expect(element('#sign-in').val()).toBe("Sign in")

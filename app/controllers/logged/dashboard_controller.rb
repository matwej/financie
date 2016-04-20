class Logged::DashboardController < LoggedController
  def index

  end

  def logins
    logins = UserLog.of(current_user)

    smart_listing_create :logins, logins, partial: "logins_list", default_sort: {id: 'asc'}
  end
end

Table Schema

Each row in the watches table tracks a user’s search and watch interaction with a specific route (origin, destination, departure date, return date) from the time the user first searched that route to the time the user has either booked, deactivated a watch, or allowed the departure date to pass without a booking or deactivation of a watch.


Here are some definitions which might help: 

user_id: a unique identifier for the user
trip_id: a unique identifier of a particular route. Each unique alert_id encodes the following fields: origin, destination, departure_date, return_date, filter combination
first_search: the first datetime in which the user_id searched the trip_id
watch_added_dt: the first datetime in which the user id watched the trip id (not a watch if null)
latest_status_change_dt: the last datetime in which the user id - trip id changed status
status_latest: shopped = search, active = active watch with departure date in the future, expired = active watch with departure date in the past, inactive = active watch that was removed by the user, booked = the search/watch was booked. 
total_notifs: total number of notifs we sent the user about the search/watch
total_buy_notifs: total buy recommendation notifs we sent the user about the watch/search
first_buy_total: the USD value of the first buy recommendation
lowest_total: the lowest USD value the user saw for this trip id
last_notif_dt: the datetime of the latest notification we sent the user about this trip id
 
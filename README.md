# Twittoo

To start your Phoenix server:
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Overview of the architecture:
Read/Write operations has been shaped as separation implementations so that those concerns will be handled and scaled independently.
There 4 additional processes handling timer, client server session data, read data storage, write data storage.
The communication protocol is Websocket and http.

Details:
The timer will be triggered periodically and it is subjective to every 60secs. It will callback to the process handling time consuming tasks like sorting and aggregating.
It also updates the ordered tweets collection to key-value store for read concern.
About the session data, I implemented a very simple server side session store to save the current page state for pagination feature. Noted that I could not use cookies and session provided by Phoenix framework because of having two different connection contexts (websocket/http).
The read storage is updated every 60secs after sorting process has been triggered. There are some functions for data related info like count, get_top_ten.
The write data storage has two KV tables for tweets and retweet context. The bipartite graph problem in this relation has reduced to matrix like KV representation. There are functions to increase the number of retweets and store new tweets. They are implemented in separated modules along with aggregation context.

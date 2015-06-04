Devise::Async.backend = :delayed_job
Devise::Async.enabled = true
Devise::Async.queue = :mailers
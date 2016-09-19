# A Very Simple Consul Cookbook

I'm writing this cookbook to teack myself how to set up [Consul][1] from
scratch. If you find it useful, great!

I'll add more to this readme when I have something useful to say. :)

For now, the two recipes that will be installed are:

## `consul_minimal::install`

Will install Consul with a **minimal** configuration and a service configuration
designed to get up and running as a or client node quickly.

Note that the mode that Consul runs in is dependent on what you set for the
`node['consul_minimal']['mode']` node attribute.

## Configruation

Very little configuration should be necessary, but you can view
[attributes/default.rb](attributes/default.rb) for some items that may be
necessary, such as, for example, the datacenter that you are setting up in.
All node attributes are annotated.

[1]: https://consul.io/

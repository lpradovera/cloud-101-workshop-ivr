# SignalWire ClueCon Deconstructed 2020 Cloud IVR

This is a simple Ruby IVR designed to showcase some LAML features.

## Goals

- If in office hours, ask caller to choose Sales or Support
- Outside of office hours, ask user to record a message
- Sales calls one main number
- Support calls multiple numbers at the same time


## Running the demo

Run `bundle install`, then `ruby app.rb`.

I recommend something like [ngrok](https://ngrok.com/) to run a tunnel to your development machine.

Then, set up your phone number to use the URL as a voice handler and call the number.

## Documentation

- [LAML XML reference](https://docs.signalwire.com/topics/laml-xml)
- [LAML REST API](https://docs.signalwire.com/topics/laml-api)
- [SignalWire guides](https://signalwire.com/resources/guides)
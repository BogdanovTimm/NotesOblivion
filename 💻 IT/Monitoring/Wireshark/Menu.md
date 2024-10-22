# Analyze

## Enabled Protocols

Using this item, you can enable or disable certain protocol dissectors. Your setting is retained even after you restart Wireshark.

Be careful with this setting. If you disable a protocol, higher protocols and applications will not be decoded. For example, if you disable UDP, then applications that use UDP (such as DHCP and DNS) will not be decoded either as shown in Figure 34.

## Follow UPD, TCP, or SSL Streams

When you choose to follow a UDP stream, Wireshark creates a filter based on source/destination IP addresses and source/destination port numbers. When you choose to follow a TCP stream or SSL stream, Wireshark creates a filter based on the stream number.

## Expert Info

Wireshark can identify unusual or interesting traffic in a trace and apply a categorization and colorization to this traffic. In addition, Wireshark tracks the interesting traffic in the Expert Infos window.

# Statistics

## Conversations and Endpoints

Shows PCs and Applications that are communicaiton with each other

## Endpoints/IPv4 or IPv6

Shows PCs and Applications that are communicaiton with each other on the Global world Map

## Compare

In essence, you should capture traffic on both ends of a file transfer and merge the two trace files (using Mergecap). When you open the new merged trace file and select Statistics | Compare, this feature uses the IP ID field to match up packets.

## Flow Graphs

Flow graphs create a packet-by-packet interpretation of the traffic, separating source and target hosts by columns.

## TCP Stream Graphs

Must be very cool

# Telephony

## VoIPCalls

This is an area that thrills many VoIP analysts[40] as it enables the playback of some unencrypted VoIP calls. First Wireshark automatically detects VoIP calls (remember, if Wireshark does not detect call setup traffic it may not detect the call either), then it builds a table with the start/stop time of the call, the initial speaker, information on the source and destination of the call as well as the protocol used for the call setup.
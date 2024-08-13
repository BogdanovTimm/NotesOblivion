#                  What it is

It is a protocol that finds shortest-path without loops.

It does:
- Spanning tree defines a tree with a root switch and a loop-free path from the root to all switches in the Layer 2 network. 
- Spanning tree forces redundant data paths into a standby (blocked) state. If a network segment in the spanning tree fails and a redundant path exists, the spanning-tree algorithm recalculates the spanning-tree topology and activates the standby path.

It prevents:
- Duplicate messages - Multiple active paths among end stations cause loops in the network.
- Switches might also learn end-station MAC addresses on multiple Layer 2 interfaces.

##                 OSI Level

2, Data Link Layer.









#                  How it works

1. Switches send and receive spanning-tree frames, called bridge protocol data units (BPDUs), at regular intervals. 
2. The switches do not forward these frames, but use the frames to construct a loop-free path.
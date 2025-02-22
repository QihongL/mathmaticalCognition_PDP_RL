# pdp approach to matematical cognition
For the summer research project at Stanford CSLI,
 supervised by Professor Jay McClelland.

There is an RL driven model for a couting sub-task. Given a sequence of objects (<=7), placed on a one-dimensional line, the model learns to touch everything exactly once from left to right. The following figures display the model's architecture and its performance under different training regime. 
 
 
 Here's the model. It learns via the Q learning rule, supported by a linear neural network function approximator.  
 
 <img src="https://github.com/QihongL/mathCognition_PDP_RL/blob/master/%5Bplots%5D/demo_git/model.png" width="600">
 
 Since the model is so simple, model follows the standard RL fails to learn the task. However, with "intermediate feedback" and "teaching", the model can learn the task quite well (especially when you combine these two strategies). 
 
 <img src="https://github.com/QihongL/mathCognition_PDP_RL/blob/master/%5Bplots%5D/demo_git/performance.png" width="800">
 
 Even with additional teaching strategies, we needed 10,000 epochs to train the model (figure above). It turns out the training experience required can be reduced substantially with an experience replay buffer. 
 
 
 
 Specifically, the replay buffer store the most recent 500 transitions {s_t, a_t, r_t, s_t+1}. In each epoch, the model learns from a batch of transitions (with fixed batch size), sampled uniformly with replacement from the buffer. All models use the combination of intermediate reward and teacher demonstration. When the model is augmented with the replay buffer, it only needs 500 epochs to match the previous performance (figure below). However, too many replay (red curve) doesn't help and it can even be detrimental. 
 
 <img src="https://github.com/QihongL/mathCognition_PDP_RL/blob/master/%5Bplots%5D/demo_git/replay/compareReplay500.jpg" width="700">
 


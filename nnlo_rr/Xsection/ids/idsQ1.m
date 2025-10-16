(* Created with the Wolfram Language : www.wolfram.com *)
{G[(r*t)/(-1 + r*t), 1] -> -Log[r] - Log[t], G[(2*r*t)/(-1 + r*t), 1] -> 
  -Log[2] - Log[r] - Log[t] + Log[1 + r*t], G[(r^2 + r*t)/(-1 + r*t), 1] -> 
  -Log[r] + Log[1 + r^2] - Log[r + t], G[t^2/(-1 + t^2), 1] -> -2*Log[t], 
 G[(2*t^2)/(-1 + t^2), 1] -> -Log[2] - 2*Log[t] + Log[1 + t^2], 
 G[0, (2*t^2)/(-1 + t^2), 1] -> G[0, (2*t^2)/(-1 + t^2), 1], 
 G[t^2/(-1 + t^2), 0, 1] -> G[t^2/(-1 + t^2), 0, 1], 
 G[t^2/(-1 + t^2), (2*t^2)/(-1 + t^2), 1] -> 
  G[t^2/(-1 + t^2), (2*t^2)/(-1 + t^2), 1]}

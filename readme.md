# Multi-Agent Collision Avoidance

This implementation is based on the ideas from http://www.alonsomora.com/docs/18-alonsomora-TRO.pdf

## Running the code

`run.m` is the main file that calls other functions in the directory. This file has the configurations related to the agents, axis limits for plots.

**Note**: If you are saving the plots to the disk as images, you need to create `run` directory before hand or the execution will fail. If there are images from a previous execution in this directory, those files will be overwritten.

## Configuring the agents

The agents are declared at the beginning of [`run.m`](run.m#L8). For example, if you want to run the simulation with two agents, the array should more or less look like

```matlab
agents = [
    addAgent('Agent-1', [-5 -5], [0 0], [ 5  5]),
    addAgent('Agent-2', [ 5  5], [0 0], [-5 -5])
]
```

Usage for `addAgent` function is

```matlab
addAgent("Name of the agent", [initial position], [initial velocity], [goal position])
```

## Configuring the plot

- The axis limits of the plot are defined in [`run.m`](run.m#L14).
- `plotSimulation` plots the current state of the agents along with their past path. This function is called in [`run.m#L51`](run.m#L51).
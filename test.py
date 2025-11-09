# %% do this
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd


def hello():
    print("Hello, world!")

df = pd.DataFrame({"x": [1, 2, 3], "y": [4, 5, 6]})
print(df)  # Table preview
plt.plot(df["x"], df["y"])
plt.show()

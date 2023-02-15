import pandas as pd
# import numpy as np
from sklearn.linear_model import LinearRegression #old model 70percent accuracy
from sklearn.tree import DecisionTreeRegressor #new model 99.97 accuracy
from sklearn.model_selection import train_test_split
from sklearn import metrics
from sklearn.metrics import accuracy_score, r2_score
import joblib
import pickle

# Load data into a pandas DataFrame
data = pd.read_excel("C:\\Users\\punya\\OneDrive - Shiv Nadar Institution of Eminence\\Desktop\\ML Implementation\\Dataset_Hackathon.xlsx") # adjust this path according to xlsx file location

# Split the data into training and test sets
# x = data[["feature1", "feature2", "feature3"]]
# x = data[["Quantity", "Volume (m^3)", "Distance from India (m)"]]#, "Frieght Cost (USD)"]]
x = data[["Quantity", "Volume (m^3)", "Distance from India (m)"]]
y = data["Frieght Cost (USD)"]
x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2)


# Initialize and fit the linear regression model
# model = LinearRegression()
model = DecisionTreeRegressor()
model.fit(x_train, y_train)

with open('data.pkl', 'wb') as f:
    pickle.dump(model, f)

# print(x_test)


# # Make predictions on the test set
# y_pred = model.predict(x_test)
# y_pred = model.predict(x_test.values)
# pd.DataFrame(X_test, columns=X_train.columns)
y_pred = model.predict(pd.DataFrame(x_test, columns=x_train.columns))

Quantity=int(input("\nEnter The Quantity: "))
Volume=int(input("Enter The Volume (m^3): "))
Distance=float(input("Enter The Distance from India (m): "))

# print(type(model.predict([[32, 12, 5941]])))
print("The estimated cost is ", end="")
print(model.predict(pd.DataFrame([[Quantity, Volume, Distance]], columns=x_train.columns))[0])

# Evaluate the model's performance
print("\n\nR^2:", r2_score(y_test, y_pred))
input("\n \npress any key to exit")
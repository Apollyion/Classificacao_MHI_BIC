import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.naive_bayes import MultinomialNB
from sklearn.pipeline import make_pipeline, make_union
from sklearn.tree import DecisionTreeClassifier
from tpot.builtins import StackingEstimator

# NOTE: Make sure that the outcome column is labeled 'target' in the data file
tpot_data = pd.read_csv('PATH/TO/DATA/FILE', sep='COLUMN_SEPARATOR', dtype=np.float64)
features = tpot_data.drop('target', axis=1)
training_features, testing_features, training_target, testing_target = \
            train_test_split(features, tpot_data['target'], random_state=None)

# Average CV score on the training set was: 0.7834326824254881
exported_pipeline = make_pipeline(
    StackingEstimator(estimator=MultinomialNB(alpha=10.0, fit_prior=True)),
    DecisionTreeClassifier(criterion="gini", max_depth=2, min_samples_leaf=13, min_samples_split=19)
)

exported_pipeline.fit(training_features, training_target)
results = exported_pipeline.predict(testing_features)

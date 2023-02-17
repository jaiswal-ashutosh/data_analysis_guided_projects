<h1> Data Analysis Projects</h1>
<br>
<h3> Required Packages </h3>
<ul>
  <li>
    pip install numpy
  </li>
  <li>
    pip install pandas
  </li>
  <li>
    pip install matplotlib
  </li>
  <li>
    pip install seaborn
  </li>
  <li>
    pip install plotly
  </li>
  </ul>
  <div>
  <h2><a href="https://github.com/jaiswal-ashutosh/data-analyst-projects/blob/master/Youtube_analysis.ipynb">Youtube Sentiment Analysis</a></h2>
  First 
  <ul>
  <li>import pandas as pd</li>
  <li>import numpy as np</li>
  <li>import seaborn as sns</li>
  <li>import matplotlib.pyplot as plt</li>
  </ul>
  <span>
    <p>
      Read comments.csv file. Check first rows and columns using head method.
      Now check if there are any null values in columns. If there are null value then drop those rows in which null values are present.
      <br>
      Now install textblob package and import TextBlob from textblob.
      <li><b>pip install textblob</b></li>
      Find sentiment polarity of comment_text column and stored in a new column.
      If comments polarity is 1 then there are positive comments. If comments polarity is -1 then there are negative comments.
    <br>
   Now install wordcloud package and import WordCloud and STOPWORDS from wordcloud.
  <br>
  Now we can visualize positive and negative words using wordcloud and matplotlib.
      <br>
      Now <li><b>pip install emoji</b></li> and import emoji. find the emoji's uses in comments and list it. Count which emoji is sent how much time. Plot the graph of emoji counts using plotly.
    </p>
    <p>
      Store multiple country data csv files in a list. Read all files and stored in a data frame. By using head method check columns of the data frame. Read category file and map both files by using category id and category name.
      <br>
      Group the data by category names and it's likes. Use the bar plot show which category have most likes.
      <br>
      To check whether audience is engaged or not find likes rate, dislike rate and comment rate. For whole data plot a regression plot between views and likes using seaborn.
      <br>
      <br>
      To check which channel have the largest number of videos group by channel title and total videos.
       <br>
      <br>
      To check punctuation in title impact on views first count punctuation in each title and stored in a coulmn, and then graph a boxplot between views and likes.
    </p>
  </span>
  </div>
  

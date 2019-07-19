import pandas as pd
import plotly.plotly as py
import plotly.graph_objs as go

df = pd.read_csv('C:/Users/gurkaali/Documents/Info/Ben/Data-Challenges/DataViz/new 1.txt',sep='\t')
df.info()
df['code'].unique()

scl = [
    [0.0, 'rgb(242,240,247)'],
    [0.2, 'rgb(218,218,235)'],
    [0.4, 'rgb(188,189,220)'],
    [0.6, 'rgb(158,154,200)'],
    [0.8, 'rgb(117,107,177)'],
    [1.0, 'rgb(84,39,143)']
]

df2 = df.groupby('code').size()

data = [go.Choropleth(
    colorscale = scl,
    autocolorscale = False,
    locations = df2.index, 
    z = df2.astype(float), 
    locationmode = 'USA-states',
    #text = df['text'],
    marker = go.choropleth.Marker(
        line = go.choropleth.marker.Line(
            color = 'rgb(255,255,255)',
            width = 2
        )),
    colorbar = go.choropleth.ColorBar(
        title = "Number of Attacks \n Since 1900")
)]

layout = go.Layout(
    title = go.layout.Title(
        text = 'Bear Attacks Across US'
    ),
    geo = go.layout.Geo(
        scope = 'usa',
        projection = go.layout.geo.Projection(type = 'albers usa'),
        showlakes = True,
        lakecolor = 'rgb(255, 255, 255)'),
)

fig = go.Figure(data = data, layout = layout)
py.iplot(fig, filename = 'd3-cloropleth-map')
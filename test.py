import polars as pl
import altair as alt

df = pl.DataFrame({
    "year": [2020, 2021, 2022, 2023, 2024],
    "gdp_growth": [-3.5, 5.9, 2.1, 2.9, 2.4],
    "category": ["A", "A", "B", "B", "B"]
})

chart = (
    alt.Chart(df)
    .mark_line(point=True)
    .encode(
        x=alt.X("year", title="Year"),
        y=alt.Y("gdp_growth", title="GDP Growth (%)"),
        color=alt.Color("category", title="Sector"),
        tooltip=["year", "gdp_growth"]
    )
    .properties(
        title="Economic stuff"
    )
)

chart.save("chart.html")

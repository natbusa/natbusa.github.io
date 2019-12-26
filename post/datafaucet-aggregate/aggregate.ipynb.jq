{
  "cells": [
    {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        "## Getting started\n",
        "\n",
        "Let's start spark using datafaucet."
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 23,
      "metadata": {},
      "outputs": [],
      "source": [
        "import datafaucet as dfc"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 24,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/plain": [
              "<datafaucet.spark.engine.SparkEngine at 0x7fbdb66f2128>"
            ]
          },
          "execution_count": 24,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "# let's start the engine\n",
        "dfc.engine('spark')"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 25,
      "metadata": {},
      "outputs": [],
      "source": [
        "# expose the engine context\n",
        "spark  = dfc.context()"
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        "## Generating Data"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 70,
      "metadata": {},
      "outputs": [],
      "source": [
        "df = spark.range(100)"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 97,
      "metadata": {},
      "outputs": [],
      "source": [
        "df = (df\n",
        "    .cols.create('g').randint(0,3)\n",
        "    .cols.create('n').randchoice(['Stacy', 'Sandra'])\n",
        "    .cols.create('x').randint(0,100)\n",
        "    .cols.create('y').randint(0,100)\n",
        ")"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 98,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/html": [
              "<div>\n",
              "<style scoped>\n",
              "    .dataframe tbody tr th:only-of-type {\n",
              "        vertical-align: middle;\n",
              "    }\n",
              "\n",
              "    .dataframe tbody tr th {\n",
              "        vertical-align: top;\n",
              "    }\n",
              "\n",
              "    .dataframe thead th {\n",
              "        text-align: right;\n",
              "    }\n",
              "</style>\n",
              "<table border=\"1\" class=\"dataframe\">\n",
              "  <thead>\n",
              "    <tr style=\"text-align: right;\">\n",
              "      <th></th>\n",
              "      <th>id</th>\n",
              "      <th>g</th>\n",
              "      <th>n</th>\n",
              "      <th>x</th>\n",
              "      <th>y</th>\n",
              "    </tr>\n",
              "  </thead>\n",
              "  <tbody>\n",
              "    <tr>\n",
              "      <td>0</td>\n",
              "      <td>0</td>\n",
              "      <td>1</td>\n",
              "      <td>Sandra</td>\n",
              "      <td>91</td>\n",
              "      <td>89</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>1</td>\n",
              "      <td>1</td>\n",
              "      <td>0</td>\n",
              "      <td>Sandra</td>\n",
              "      <td>19</td>\n",
              "      <td>57</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>2</td>\n",
              "      <td>2</td>\n",
              "      <td>2</td>\n",
              "      <td>Sandra</td>\n",
              "      <td>34</td>\n",
              "      <td>97</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>3</td>\n",
              "      <td>3</td>\n",
              "      <td>1</td>\n",
              "      <td>Stacy</td>\n",
              "      <td>35</td>\n",
              "      <td>15</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>4</td>\n",
              "      <td>4</td>\n",
              "      <td>2</td>\n",
              "      <td>Sandra</td>\n",
              "      <td>93</td>\n",
              "      <td>90</td>\n",
              "    </tr>\n",
              "  </tbody>\n",
              "</table>\n",
              "</div>"
            ],
            "text/plain": [
              "   id  g       n   x   y\n",
              "0   0  1  Sandra  91  89\n",
              "1   1  0  Sandra  19  57\n",
              "2   2  2  Sandra  34  97\n",
              "3   3  1   Stacy  35  15\n",
              "4   4  2  Sandra  93  90"
            ]
          },
          "execution_count": 98,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "df.data.grid(5)"
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        "## Pandas\n",
        "Let's start by looking how Pandas does aggregations. Pandas is quite flexible on the points noted above and uses hierachical indexes on both columns and rows to store the aggregation names and the groupby values. Here below a simple aggregation and a more complex one with groupby and multiple aggregation functions."
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 99,
      "metadata": {},
      "outputs": [],
      "source": [
        "pf = df.data.collect()"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 100,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/html": [
              "<div>\n",
              "<style scoped>\n",
              "    .dataframe tbody tr th:only-of-type {\n",
              "        vertical-align: middle;\n",
              "    }\n",
              "\n",
              "    .dataframe tbody tr th {\n",
              "        vertical-align: top;\n",
              "    }\n",
              "\n",
              "    .dataframe thead th {\n",
              "        text-align: right;\n",
              "    }\n",
              "</style>\n",
              "<table border=\"1\" class=\"dataframe\">\n",
              "  <thead>\n",
              "    <tr style=\"text-align: right;\">\n",
              "      <th></th>\n",
              "      <th>n</th>\n",
              "      <th>x</th>\n",
              "      <th>y</th>\n",
              "    </tr>\n",
              "  </thead>\n",
              "  <tbody>\n",
              "    <tr>\n",
              "      <td>max</td>\n",
              "      <td>Stacy</td>\n",
              "      <td>97</td>\n",
              "      <td>98</td>\n",
              "    </tr>\n",
              "  </tbody>\n",
              "</table>\n",
              "</div>"
            ],
            "text/plain": [
              "         n   x   y\n",
              "max  Stacy  97  98"
            ]
          },
          "execution_count": 100,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "pf[['n', 'x', 'y']].agg(['max'])"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 103,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/html": [
              "<div>\n",
              "<style scoped>\n",
              "    .dataframe tbody tr th:only-of-type {\n",
              "        vertical-align: middle;\n",
              "    }\n",
              "\n",
              "    .dataframe tbody tr th {\n",
              "        vertical-align: top;\n",
              "    }\n",
              "\n",
              "    .dataframe thead tr th {\n",
              "        text-align: left;\n",
              "    }\n",
              "\n",
              "    .dataframe thead tr:last-of-type th {\n",
              "        text-align: right;\n",
              "    }\n",
              "</style>\n",
              "<table border=\"1\" class=\"dataframe\">\n",
              "  <thead>\n",
              "    <tr>\n",
              "      <th></th>\n",
              "      <th></th>\n",
              "      <th>n</th>\n",
              "      <th colspan=\"2\" halign=\"left\">x</th>\n",
              "      <th colspan=\"2\" halign=\"left\">y</th>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th></th>\n",
              "      <th></th>\n",
              "      <th>count</th>\n",
              "      <th>min</th>\n",
              "      <th>max</th>\n",
              "      <th>min</th>\n",
              "      <th>max</th>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>g</th>\n",
              "      <th>n</th>\n",
              "      <th></th>\n",
              "      <th></th>\n",
              "      <th></th>\n",
              "      <th></th>\n",
              "      <th></th>\n",
              "    </tr>\n",
              "  </thead>\n",
              "  <tbody>\n",
              "    <tr>\n",
              "      <td rowspan=\"2\" valign=\"top\">0</td>\n",
              "      <td>Sandra</td>\n",
              "      <td>9</td>\n",
              "      <td>14</td>\n",
              "      <td>75</td>\n",
              "      <td>3</td>\n",
              "      <td>98</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>Stacy</td>\n",
              "      <td>21</td>\n",
              "      <td>10</td>\n",
              "      <td>96</td>\n",
              "      <td>8</td>\n",
              "      <td>92</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td rowspan=\"2\" valign=\"top\">1</td>\n",
              "      <td>Sandra</td>\n",
              "      <td>20</td>\n",
              "      <td>8</td>\n",
              "      <td>91</td>\n",
              "      <td>9</td>\n",
              "      <td>91</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>Stacy</td>\n",
              "      <td>18</td>\n",
              "      <td>2</td>\n",
              "      <td>89</td>\n",
              "      <td>4</td>\n",
              "      <td>97</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td rowspan=\"2\" valign=\"top\">2</td>\n",
              "      <td>Sandra</td>\n",
              "      <td>12</td>\n",
              "      <td>4</td>\n",
              "      <td>97</td>\n",
              "      <td>1</td>\n",
              "      <td>98</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>Stacy</td>\n",
              "      <td>20</td>\n",
              "      <td>4</td>\n",
              "      <td>96</td>\n",
              "      <td>0</td>\n",
              "      <td>98</td>\n",
              "    </tr>\n",
              "  </tbody>\n",
              "</table>\n",
              "</div>"
            ],
            "text/plain": [
              "             n   x       y    \n",
              "         count min max min max\n",
              "g n                           \n",
              "0 Sandra     9  14  75   3  98\n",
              "  Stacy     21  10  96   8  92\n",
              "1 Sandra    20   8  91   9  91\n",
              "  Stacy     18   2  89   4  97\n",
              "2 Sandra    12   4  97   1  98\n",
              "  Stacy     20   4  96   0  98"
            ]
          },
          "execution_count": 103,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "agg = (pf[['g','n', 'x', 'y']]\n",
        "           .groupby(['g', 'n'])\n",
        "           .agg({\n",
        "               'n': 'count',\n",
        "               'x': ['min', max],\n",
        "               'y':['min', 'max']\n",
        "           }))\n",
        "agg"
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        "### Stacking \n",
        "In pandas, you can stack the multiple column index and move it to a column, as below. The choice of stacking or not after aggregation depends on wht you want to do later with the data. Next to the extra index, stacking also explicitely code NaN / Nulls for evry aggregation which is not shared by each column (in case of dict of aggregation functions."
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 139,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/html": [
              "<div>\n",
              "<style scoped>\n",
              "    .dataframe tbody tr th:only-of-type {\n",
              "        vertical-align: middle;\n",
              "    }\n",
              "\n",
              "    .dataframe tbody tr th {\n",
              "        vertical-align: top;\n",
              "    }\n",
              "\n",
              "    .dataframe thead th {\n",
              "        text-align: right;\n",
              "    }\n",
              "</style>\n",
              "<table border=\"1\" class=\"dataframe\">\n",
              "  <thead>\n",
              "    <tr style=\"text-align: right;\">\n",
              "      <th></th>\n",
              "      <th></th>\n",
              "      <th>max</th>\n",
              "      <th>mean</th>\n",
              "      <th>min</th>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>g</th>\n",
              "      <th></th>\n",
              "      <th></th>\n",
              "      <th></th>\n",
              "      <th></th>\n",
              "    </tr>\n",
              "  </thead>\n",
              "  <tbody>\n",
              "    <tr>\n",
              "      <td rowspan=\"2\" valign=\"top\">0</td>\n",
              "      <td>x</td>\n",
              "      <td>96</td>\n",
              "      <td>50.966667</td>\n",
              "      <td>10</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>y</td>\n",
              "      <td>98</td>\n",
              "      <td>47.133333</td>\n",
              "      <td>3</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td rowspan=\"2\" valign=\"top\">1</td>\n",
              "      <td>x</td>\n",
              "      <td>91</td>\n",
              "      <td>45.026316</td>\n",
              "      <td>2</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>y</td>\n",
              "      <td>97</td>\n",
              "      <td>48.736842</td>\n",
              "      <td>4</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td rowspan=\"2\" valign=\"top\">2</td>\n",
              "      <td>x</td>\n",
              "      <td>97</td>\n",
              "      <td>58.750000</td>\n",
              "      <td>4</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>y</td>\n",
              "      <td>98</td>\n",
              "      <td>53.906250</td>\n",
              "      <td>0</td>\n",
              "    </tr>\n",
              "  </tbody>\n",
              "</table>\n",
              "</div>"
            ],
            "text/plain": [
              "     max       mean  min\n",
              "g                       \n",
              "0 x   96  50.966667   10\n",
              "  y   98  47.133333    3\n",
              "1 x   91  45.026316    2\n",
              "  y   97  48.736842    4\n",
              "2 x   97  58.750000    4\n",
              "  y   98  53.906250    0"
            ]
          },
          "execution_count": 139,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "agg = pf[['g', 'x', 'y']].groupby(['g']).agg(['min', 'max', 'mean'])\n",
        "agg = agg.stack(0)\n",
        "agg"
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        "### Index as columns\n",
        "Index in pandas is not the same as column data, but you can easily move from one to the other, as shown below, by combine the name information of the various index levels with the values of each level."
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 140,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/plain": [
              "FrozenList(['g', None])"
            ]
          },
          "execution_count": 140,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "agg.index.names"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 141,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/plain": [
              "Int64Index([0, 0, 1, 1, 2, 2], dtype='int64', name='g')"
            ]
          },
          "execution_count": 141,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "# for example these are the value from the first level of the index\n",
        "agg.index.get_level_values(0)"
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        "The following script will iterate through all the levels and create a column with the name of the original index level otherwise will use `_<level#>` if no name is available. Remember that pandas allows indexes to be nameless."
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 142,
      "metadata": {},
      "outputs": [],
      "source": [
        "levels = agg.index.names\n",
        "for (name, lvl) in zip(levels, range(len(levels))):\n",
        "    agg[name or f'_{lvl}'] = agg.index.get_level_values(lvl)"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 143,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/html": [
              "<div>\n",
              "<style scoped>\n",
              "    .dataframe tbody tr th:only-of-type {\n",
              "        vertical-align: middle;\n",
              "    }\n",
              "\n",
              "    .dataframe tbody tr th {\n",
              "        vertical-align: top;\n",
              "    }\n",
              "\n",
              "    .dataframe thead th {\n",
              "        text-align: right;\n",
              "    }\n",
              "</style>\n",
              "<table border=\"1\" class=\"dataframe\">\n",
              "  <thead>\n",
              "    <tr style=\"text-align: right;\">\n",
              "      <th></th>\n",
              "      <th>max</th>\n",
              "      <th>mean</th>\n",
              "      <th>min</th>\n",
              "      <th>g</th>\n",
              "      <th>_1</th>\n",
              "    </tr>\n",
              "  </thead>\n",
              "  <tbody>\n",
              "    <tr>\n",
              "      <td>0</td>\n",
              "      <td>96</td>\n",
              "      <td>50.966667</td>\n",
              "      <td>10</td>\n",
              "      <td>0</td>\n",
              "      <td>x</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>1</td>\n",
              "      <td>98</td>\n",
              "      <td>47.133333</td>\n",
              "      <td>3</td>\n",
              "      <td>0</td>\n",
              "      <td>y</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>2</td>\n",
              "      <td>91</td>\n",
              "      <td>45.026316</td>\n",
              "      <td>2</td>\n",
              "      <td>1</td>\n",
              "      <td>x</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>3</td>\n",
              "      <td>97</td>\n",
              "      <td>48.736842</td>\n",
              "      <td>4</td>\n",
              "      <td>1</td>\n",
              "      <td>y</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>4</td>\n",
              "      <td>97</td>\n",
              "      <td>58.750000</td>\n",
              "      <td>4</td>\n",
              "      <td>2</td>\n",
              "      <td>x</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>5</td>\n",
              "      <td>98</td>\n",
              "      <td>53.906250</td>\n",
              "      <td>0</td>\n",
              "      <td>2</td>\n",
              "      <td>y</td>\n",
              "    </tr>\n",
              "  </tbody>\n",
              "</table>\n",
              "</div>"
            ],
            "text/plain": [
              "   max       mean  min  g _1\n",
              "0   96  50.966667   10  0  x\n",
              "1   98  47.133333    3  0  y\n",
              "2   91  45.026316    2  1  x\n",
              "3   97  48.736842    4  1  y\n",
              "4   97  58.750000    4  2  x\n",
              "5   98  53.906250    0  2  y"
            ]
          },
          "execution_count": 143,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "#now the index is standard columns, drop the index\n",
        "agg.reset_index(inplace=True, drop=True)\n",
        "agg"
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        "## Spark (Python)\n",
        "Spark aggregation is a bit simpler, but definitely very flexible, so we can achieve the same result with a little more work in some cases. Here below a simple example and a more complex one, reproducing the same three cases as above."
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 165,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/html": [
              "<div>\n",
              "<style scoped>\n",
              "    .dataframe tbody tr th:only-of-type {\n",
              "        vertical-align: middle;\n",
              "    }\n",
              "\n",
              "    .dataframe tbody tr th {\n",
              "        vertical-align: top;\n",
              "    }\n",
              "\n",
              "    .dataframe thead th {\n",
              "        text-align: right;\n",
              "    }\n",
              "</style>\n",
              "<table border=\"1\" class=\"dataframe\">\n",
              "  <thead>\n",
              "    <tr style=\"text-align: right;\">\n",
              "      <th></th>\n",
              "      <th>max(x)</th>\n",
              "      <th>max(y)</th>\n",
              "      <th>max(n)</th>\n",
              "    </tr>\n",
              "  </thead>\n",
              "  <tbody>\n",
              "    <tr>\n",
              "      <td>0</td>\n",
              "      <td>97</td>\n",
              "      <td>98</td>\n",
              "      <td>Stacy</td>\n",
              "    </tr>\n",
              "  </tbody>\n",
              "</table>\n",
              "</div>"
            ],
            "text/plain": [
              "   max(x)  max(y) max(n)\n",
              "0      97      98  Stacy"
            ]
          },
          "execution_count": 165,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "df.select('n', 'x', 'y').agg({'n':'max', 'x':'max', 'y':'max'}).toPandas()"
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        "Or with a little more work we can exactly reproduce the pandas case:"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 166,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/html": [
              "<div>\n",
              "<style scoped>\n",
              "    .dataframe tbody tr th:only-of-type {\n",
              "        vertical-align: middle;\n",
              "    }\n",
              "\n",
              "    .dataframe tbody tr th {\n",
              "        vertical-align: top;\n",
              "    }\n",
              "\n",
              "    .dataframe thead th {\n",
              "        text-align: right;\n",
              "    }\n",
              "</style>\n",
              "<table border=\"1\" class=\"dataframe\">\n",
              "  <thead>\n",
              "    <tr style=\"text-align: right;\">\n",
              "      <th></th>\n",
              "      <th>_idx</th>\n",
              "      <th>n</th>\n",
              "      <th>x</th>\n",
              "      <th>y</th>\n",
              "    </tr>\n",
              "  </thead>\n",
              "  <tbody>\n",
              "    <tr>\n",
              "      <td>0</td>\n",
              "      <td>max</td>\n",
              "      <td>Stacy</td>\n",
              "      <td>97</td>\n",
              "      <td>98</td>\n",
              "    </tr>\n",
              "  </tbody>\n",
              "</table>\n",
              "</div>"
            ],
            "text/plain": [
              "  _idx      n   x   y\n",
              "0  max  Stacy  97  98"
            ]
          },
          "execution_count": 166,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "from pyspark.sql import functions as F\n",
        "\n",
        "df.select('n', 'x', 'y').agg(\n",
        "    F.lit('max').alias('_idx'),\n",
        "    F.max('n').alias('n'), \n",
        "    F.max('x').alias('x'), \n",
        "    F.max('y').alias('y')).toPandas()"
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        "More complicated aggregation cannot be called by string and must be provided by functions. Here below a way to reproduce groupby aggregation as in the second pandas example:"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 168,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/html": [
              "<div>\n",
              "<style scoped>\n",
              "    .dataframe tbody tr th:only-of-type {\n",
              "        vertical-align: middle;\n",
              "    }\n",
              "\n",
              "    .dataframe tbody tr th {\n",
              "        vertical-align: top;\n",
              "    }\n",
              "\n",
              "    .dataframe thead th {\n",
              "        text-align: right;\n",
              "    }\n",
              "</style>\n",
              "<table border=\"1\" class=\"dataframe\">\n",
              "  <thead>\n",
              "    <tr style=\"text-align: right;\">\n",
              "      <th></th>\n",
              "      <th>g</th>\n",
              "      <th>n</th>\n",
              "      <th>n_count</th>\n",
              "      <th>x_min</th>\n",
              "      <th>x_max</th>\n",
              "      <th>y_min</th>\n",
              "      <th>y_max</th>\n",
              "    </tr>\n",
              "  </thead>\n",
              "  <tbody>\n",
              "    <tr>\n",
              "      <td>0</td>\n",
              "      <td>0</td>\n",
              "      <td>Sandra</td>\n",
              "      <td>10</td>\n",
              "      <td>17</td>\n",
              "      <td>96</td>\n",
              "      <td>8</td>\n",
              "      <td>98</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>1</td>\n",
              "      <td>0</td>\n",
              "      <td>Stacy</td>\n",
              "      <td>20</td>\n",
              "      <td>10</td>\n",
              "      <td>92</td>\n",
              "      <td>3</td>\n",
              "      <td>86</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>2</td>\n",
              "      <td>1</td>\n",
              "      <td>Stacy</td>\n",
              "      <td>18</td>\n",
              "      <td>4</td>\n",
              "      <td>89</td>\n",
              "      <td>4</td>\n",
              "      <td>97</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>3</td>\n",
              "      <td>2</td>\n",
              "      <td>Sandra</td>\n",
              "      <td>14</td>\n",
              "      <td>29</td>\n",
              "      <td>96</td>\n",
              "      <td>1</td>\n",
              "      <td>98</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>4</td>\n",
              "      <td>1</td>\n",
              "      <td>Sandra</td>\n",
              "      <td>20</td>\n",
              "      <td>2</td>\n",
              "      <td>91</td>\n",
              "      <td>4</td>\n",
              "      <td>97</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>5</td>\n",
              "      <td>2</td>\n",
              "      <td>Stacy</td>\n",
              "      <td>18</td>\n",
              "      <td>4</td>\n",
              "      <td>97</td>\n",
              "      <td>0</td>\n",
              "      <td>96</td>\n",
              "    </tr>\n",
              "  </tbody>\n",
              "</table>\n",
              "</div>"
            ],
            "text/plain": [
              "   g       n  n_count  x_min  x_max  y_min  y_max\n",
              "0  0  Sandra       10     17     96      8     98\n",
              "1  0   Stacy       20     10     92      3     86\n",
              "2  1   Stacy       18      4     89      4     97\n",
              "3  2  Sandra       14     29     96      1     98\n",
              "4  1  Sandra       20      2     91      4     97\n",
              "5  2   Stacy       18      4     97      0     96"
            ]
          },
          "execution_count": 168,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "(df\n",
        "    .select('g', 'n', 'x', 'y')\n",
        "    .groupby('g', 'n')\n",
        "    .agg(\n",
        "        F.count('n').alias('n_count'),\n",
        "        F.min('x').alias('x_min'),\n",
        "        F.max('x').alias('x_max'),\n",
        "        F.min('y').alias('y_min'),\n",
        "        F.max('y').alias('y_max')\n",
        "    )\n",
        ").toPandas()\n",
        "        "
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        "### Stacking\n",
        "\n",
        "Stacking, as in pandas, can be used to expose the column name on a different index column, unfortunatel stack is currently available only in the SQL initerface and not very flexible as in the pandas counterpart (https://spark.apache.org/docs/2.3.0/api/sql/#stack)\n",
        "\n",
        "You could use pyspark `expr` to call the SQL function as explained here (https://stackoverflow.com/questions/42465568/unpivot-in-spark-sql-pyspark). However, another way would be to union the various results as shown here below."
      ]
    },
    {
      "cell_type": "code",
      "execution_count": null,
      "metadata": {},
      "outputs": [],
      "source": [
        "agg = pf[['g', 'x', 'y']].groupby(['g']).agg(['min', 'max', 'mean'])\n",
        "a"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 176,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/html": [
              "<div>\n",
              "<style scoped>\n",
              "    .dataframe tbody tr th:only-of-type {\n",
              "        vertical-align: middle;\n",
              "    }\n",
              "\n",
              "    .dataframe tbody tr th {\n",
              "        vertical-align: top;\n",
              "    }\n",
              "\n",
              "    .dataframe thead th {\n",
              "        text-align: right;\n",
              "    }\n",
              "</style>\n",
              "<table border=\"1\" class=\"dataframe\">\n",
              "  <thead>\n",
              "    <tr style=\"text-align: right;\">\n",
              "      <th></th>\n",
              "      <th>g</th>\n",
              "      <th>_idx</th>\n",
              "      <th>min</th>\n",
              "      <th>max</th>\n",
              "      <th>mean</th>\n",
              "    </tr>\n",
              "  </thead>\n",
              "  <tbody>\n",
              "    <tr>\n",
              "      <td>0</td>\n",
              "      <td>1</td>\n",
              "      <td>x</td>\n",
              "      <td>2</td>\n",
              "      <td>91</td>\n",
              "      <td>45.026316</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>1</td>\n",
              "      <td>2</td>\n",
              "      <td>x</td>\n",
              "      <td>4</td>\n",
              "      <td>97</td>\n",
              "      <td>58.750000</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>2</td>\n",
              "      <td>0</td>\n",
              "      <td>x</td>\n",
              "      <td>10</td>\n",
              "      <td>96</td>\n",
              "      <td>50.966667</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>3</td>\n",
              "      <td>1</td>\n",
              "      <td>y</td>\n",
              "      <td>4</td>\n",
              "      <td>97</td>\n",
              "      <td>48.736842</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>4</td>\n",
              "      <td>2</td>\n",
              "      <td>y</td>\n",
              "      <td>0</td>\n",
              "      <td>98</td>\n",
              "      <td>53.906250</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>5</td>\n",
              "      <td>0</td>\n",
              "      <td>y</td>\n",
              "      <td>3</td>\n",
              "      <td>98</td>\n",
              "      <td>47.133333</td>\n",
              "    </tr>\n",
              "  </tbody>\n",
              "</table>\n",
              "</div>"
            ],
            "text/plain": [
              "   g _idx  min  max       mean\n",
              "0  1    x    2   91  45.026316\n",
              "1  2    x    4   97  58.750000\n",
              "2  0    x   10   96  50.966667\n",
              "3  1    y    4   97  48.736842\n",
              "4  2    y    0   98  53.906250\n",
              "5  0    y    3   98  47.133333"
            ]
          },
          "execution_count": 176,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "from pyspark.sql import functions as F\n",
        "\n",
        "(df\n",
        "    .select('g', 'x')\n",
        "    .groupby('g')\n",
        "    .agg(\n",
        "        F.lit('x').alias('_idx'),\n",
        "        F.min('x').alias('min'),\n",
        "        F.max('x').alias('max'),\n",
        "        F.mean('x').alias('mean')\n",
        "    )\n",
        ").union(\n",
        "df\n",
        "    .select('g', 'y')\n",
        "    .groupby('g')\n",
        "    .agg(\n",
        "        F.lit('y').alias('_idx'),\n",
        "        F.min('y').alias('min'),\n",
        "        F.max('y').alias('max'),\n",
        "        F.mean('y').alias('mean')\n",
        "    )\n",
        ").toPandas()"
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        "### Generatring aggregating code\n",
        "\n",
        "The code above looks complicated, but is very regular, hence we can generate it! What we need is a to a list of lists for the aggregation functions as shown here below:"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 179,
      "metadata": {},
      "outputs": [
        {
          "name": "stdout",
          "output_type": "stream",
          "text": [
            "   col: x\n",
            "     func: Column<b'min(x) AS `min`'>\n",
            "     func: Column<b'max(x) AS `max`'>\n",
            "     func: Column<b'avg(x) AS `mean`'>\n",
            "   col: y\n",
            "     func: Column<b'min(y) AS `min`'>\n",
            "     func: Column<b'max(y) AS `max`'>\n",
            "     func: Column<b'avg(y) AS `mean`'>\n"
          ]
        }
      ],
      "source": [
        "dfs = []\n",
        "for c in ['x','y']:\n",
        "    print(' '*2, f'col: {c}')\n",
        "    aggs = []\n",
        "    for func in [F.min, F.max, F.mean]:\n",
        "        f = func(c).alias(func.__name__)\n",
        "        aggs.append(f)\n",
        "        print(' '*4, f'func: {f}')\n",
        "        \n",
        "    dfs.append(df.select('g', c).groupby('g').agg(*aggs))"
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        "The dataframes in this generator have all the same columns and can be reduced with union calls"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 181,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/html": [
              "<div>\n",
              "<style scoped>\n",
              "    .dataframe tbody tr th:only-of-type {\n",
              "        vertical-align: middle;\n",
              "    }\n",
              "\n",
              "    .dataframe tbody tr th {\n",
              "        vertical-align: top;\n",
              "    }\n",
              "\n",
              "    .dataframe thead th {\n",
              "        text-align: right;\n",
              "    }\n",
              "</style>\n",
              "<table border=\"1\" class=\"dataframe\">\n",
              "  <thead>\n",
              "    <tr style=\"text-align: right;\">\n",
              "      <th></th>\n",
              "      <th>g</th>\n",
              "      <th>min</th>\n",
              "      <th>max</th>\n",
              "      <th>mean</th>\n",
              "    </tr>\n",
              "  </thead>\n",
              "  <tbody>\n",
              "    <tr>\n",
              "      <td>0</td>\n",
              "      <td>1</td>\n",
              "      <td>2</td>\n",
              "      <td>91</td>\n",
              "      <td>45.026316</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>1</td>\n",
              "      <td>2</td>\n",
              "      <td>4</td>\n",
              "      <td>97</td>\n",
              "      <td>58.750000</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>2</td>\n",
              "      <td>0</td>\n",
              "      <td>10</td>\n",
              "      <td>96</td>\n",
              "      <td>50.966667</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>3</td>\n",
              "      <td>1</td>\n",
              "      <td>4</td>\n",
              "      <td>97</td>\n",
              "      <td>48.736842</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>4</td>\n",
              "      <td>2</td>\n",
              "      <td>0</td>\n",
              "      <td>98</td>\n",
              "      <td>53.906250</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>5</td>\n",
              "      <td>0</td>\n",
              "      <td>3</td>\n",
              "      <td>98</td>\n",
              "      <td>47.133333</td>\n",
              "    </tr>\n",
              "  </tbody>\n",
              "</table>\n",
              "</div>"
            ],
            "text/plain": [
              "   g  min  max       mean\n",
              "0  1    2   91  45.026316\n",
              "1  2    4   97  58.750000\n",
              "2  0   10   96  50.966667\n",
              "3  1    4   97  48.736842\n",
              "4  2    0   98  53.906250\n",
              "5  0    3   98  47.133333"
            ]
          },
          "execution_count": 181,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "from functools import reduce\n",
        "\n",
        "reduce(lambda a,b: a.union(b), dfs).toPandas()"
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        "## Meet DataFaucet agg\n",
        "\n",
        "One of the goal of datafaucet is to simplify analytics, data wrangling and data\n",
        "discovery over a set of engine with an intuitive interface. So the sketched\n",
        "solution above is available, with a few extras. See below the examples\n",
        "\n",
        "The code here below attempt to produce readable code, engine agnostic data\n",
        "aggregations. The aggregation api is always in the form:   \n",
        "\n",
        "`df.cols.get(...).groupby(...).agg(...)`\n",
        "\n",
        "Alternativaly, you can `find` instead of `get`"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 183,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/html": [
              "<div>\n",
              "<style scoped>\n",
              "    .dataframe tbody tr th:only-of-type {\n",
              "        vertical-align: middle;\n",
              "    }\n",
              "\n",
              "    .dataframe tbody tr th {\n",
              "        vertical-align: top;\n",
              "    }\n",
              "\n",
              "    .dataframe thead th {\n",
              "        text-align: right;\n",
              "    }\n",
              "</style>\n",
              "<table border=\"1\" class=\"dataframe\">\n",
              "  <thead>\n",
              "    <tr style=\"text-align: right;\">\n",
              "      <th></th>\n",
              "      <th>x</th>\n",
              "    </tr>\n",
              "  </thead>\n",
              "  <tbody>\n",
              "    <tr>\n",
              "      <td>0</td>\n",
              "      <td>64</td>\n",
              "    </tr>\n",
              "  </tbody>\n",
              "</table>\n",
              "</div>"
            ],
            "text/plain": [
              "    x\n",
              "0  64"
            ]
          },
          "execution_count": 183,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "# simple aggregation by name\n",
        "d = df.cols.get('x').agg('distinct')\n",
        "d.data.grid()"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 184,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/html": [
              "<div>\n",
              "<style scoped>\n",
              "    .dataframe tbody tr th:only-of-type {\n",
              "        vertical-align: middle;\n",
              "    }\n",
              "\n",
              "    .dataframe tbody tr th {\n",
              "        vertical-align: top;\n",
              "    }\n",
              "\n",
              "    .dataframe thead th {\n",
              "        text-align: right;\n",
              "    }\n",
              "</style>\n",
              "<table border=\"1\" class=\"dataframe\">\n",
              "  <thead>\n",
              "    <tr style=\"text-align: right;\">\n",
              "      <th></th>\n",
              "      <th>x_distinct</th>\n",
              "      <th>x_avg</th>\n",
              "    </tr>\n",
              "  </thead>\n",
              "  <tbody>\n",
              "    <tr>\n",
              "      <td>0</td>\n",
              "      <td>64</td>\n",
              "      <td>51.2</td>\n",
              "    </tr>\n",
              "  </tbody>\n",
              "</table>\n",
              "</div>"
            ],
            "text/plain": [
              "   x_distinct  x_avg\n",
              "0          64   51.2"
            ]
          },
          "execution_count": 184,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "# simple aggregation (multiple) by name\n",
        "d = df.cols.get('x').agg(['distinct', 'avg'])\n",
        "d.data.grid()"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 185,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/html": [
              "<div>\n",
              "<style scoped>\n",
              "    .dataframe tbody tr th:only-of-type {\n",
              "        vertical-align: middle;\n",
              "    }\n",
              "\n",
              "    .dataframe tbody tr th {\n",
              "        vertical-align: top;\n",
              "    }\n",
              "\n",
              "    .dataframe thead th {\n",
              "        text-align: right;\n",
              "    }\n",
              "</style>\n",
              "<table border=\"1\" class=\"dataframe\">\n",
              "  <thead>\n",
              "    <tr style=\"text-align: right;\">\n",
              "      <th></th>\n",
              "      <th>_idx</th>\n",
              "      <th>distinct</th>\n",
              "      <th>avg</th>\n",
              "    </tr>\n",
              "  </thead>\n",
              "  <tbody>\n",
              "    <tr>\n",
              "      <td>0</td>\n",
              "      <td>x</td>\n",
              "      <td>64</td>\n",
              "      <td>51.2</td>\n",
              "    </tr>\n",
              "  </tbody>\n",
              "</table>\n",
              "</div>"
            ],
            "text/plain": [
              "  _idx  distinct   avg\n",
              "0    x        64  51.2"
            ]
          },
          "execution_count": 185,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "# simple aggregation (multiple) by name (stacked)\n",
        "d = df.cols.get('x').agg(['distinct', 'avg'], stack=True)\n",
        "d.data.grid()"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 186,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/html": [
              "<div>\n",
              "<style scoped>\n",
              "    .dataframe tbody tr th:only-of-type {\n",
              "        vertical-align: middle;\n",
              "    }\n",
              "\n",
              "    .dataframe tbody tr th {\n",
              "        vertical-align: top;\n",
              "    }\n",
              "\n",
              "    .dataframe thead th {\n",
              "        text-align: right;\n",
              "    }\n",
              "</style>\n",
              "<table border=\"1\" class=\"dataframe\">\n",
              "  <thead>\n",
              "    <tr style=\"text-align: right;\">\n",
              "      <th></th>\n",
              "      <th>colname</th>\n",
              "      <th>distinct</th>\n",
              "      <th>avg</th>\n",
              "    </tr>\n",
              "  </thead>\n",
              "  <tbody>\n",
              "    <tr>\n",
              "      <td>0</td>\n",
              "      <td>x</td>\n",
              "      <td>64</td>\n",
              "      <td>51.2</td>\n",
              "    </tr>\n",
              "  </tbody>\n",
              "</table>\n",
              "</div>"
            ],
            "text/plain": [
              "  colname  distinct   avg\n",
              "0       x        64  51.2"
            ]
          },
          "execution_count": 186,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "# simple aggregation (multiple) by name (stacked, custom index name)\n",
        "d = df.cols.get('x').agg(['distinct', 'avg'], stack='colname')\n",
        "d.data.grid()"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 190,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/html": [
              "<div>\n",
              "<style scoped>\n",
              "    .dataframe tbody tr th:only-of-type {\n",
              "        vertical-align: middle;\n",
              "    }\n",
              "\n",
              "    .dataframe tbody tr th {\n",
              "        vertical-align: top;\n",
              "    }\n",
              "\n",
              "    .dataframe thead th {\n",
              "        text-align: right;\n",
              "    }\n",
              "</style>\n",
              "<table border=\"1\" class=\"dataframe\">\n",
              "  <thead>\n",
              "    <tr style=\"text-align: right;\">\n",
              "      <th></th>\n",
              "      <th>x_distinct</th>\n",
              "      <th>x_min</th>\n",
              "      <th>x_max</th>\n",
              "      <th>x_avg</th>\n",
              "    </tr>\n",
              "  </thead>\n",
              "  <tbody>\n",
              "    <tr>\n",
              "      <td>0</td>\n",
              "      <td>64</td>\n",
              "      <td>2</td>\n",
              "      <td>97</td>\n",
              "      <td>51.2</td>\n",
              "    </tr>\n",
              "  </tbody>\n",
              "</table>\n",
              "</div>"
            ],
            "text/plain": [
              "   x_distinct  x_min  x_max  x_avg\n",
              "0          64      2     97   51.2"
            ]
          },
          "execution_count": 190,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "# simple aggregation (multiple) by name and function\n",
        "d = df.cols.get('x').agg(['distinct', F.min, F.max, 'avg'])\n",
        "d.data.grid()"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 191,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/html": [
              "<div>\n",
              "<style scoped>\n",
              "    .dataframe tbody tr th:only-of-type {\n",
              "        vertical-align: middle;\n",
              "    }\n",
              "\n",
              "    .dataframe tbody tr th {\n",
              "        vertical-align: top;\n",
              "    }\n",
              "\n",
              "    .dataframe thead th {\n",
              "        text-align: right;\n",
              "    }\n",
              "</style>\n",
              "<table border=\"1\" class=\"dataframe\">\n",
              "  <thead>\n",
              "    <tr style=\"text-align: right;\">\n",
              "      <th></th>\n",
              "      <th>x_distinct</th>\n",
              "      <th>x_min</th>\n",
              "      <th>x_max</th>\n",
              "      <th>x_avg</th>\n",
              "      <th>y_distinct</th>\n",
              "      <th>y_min</th>\n",
              "      <th>y_max</th>\n",
              "      <th>y_avg</th>\n",
              "    </tr>\n",
              "  </thead>\n",
              "  <tbody>\n",
              "    <tr>\n",
              "      <td>0</td>\n",
              "      <td>64</td>\n",
              "      <td>2</td>\n",
              "      <td>97</td>\n",
              "      <td>51.2</td>\n",
              "      <td>67</td>\n",
              "      <td>0</td>\n",
              "      <td>98</td>\n",
              "      <td>49.91</td>\n",
              "    </tr>\n",
              "  </tbody>\n",
              "</table>\n",
              "</div>"
            ],
            "text/plain": [
              "   x_distinct  x_min  x_max  x_avg  y_distinct  y_min  y_max  y_avg\n",
              "0          64      2     97   51.2          67      0     98  49.91"
            ]
          },
          "execution_count": 191,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "# multiple aggregation by name and function\n",
        "d = df.cols.get('x', 'y').agg(['distinct', F.min, F.max, 'avg'])\n",
        "d.data.grid()"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 193,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/html": [
              "<div>\n",
              "<style scoped>\n",
              "    .dataframe tbody tr th:only-of-type {\n",
              "        vertical-align: middle;\n",
              "    }\n",
              "\n",
              "    .dataframe tbody tr th {\n",
              "        vertical-align: top;\n",
              "    }\n",
              "\n",
              "    .dataframe thead th {\n",
              "        text-align: right;\n",
              "    }\n",
              "</style>\n",
              "<table border=\"1\" class=\"dataframe\">\n",
              "  <thead>\n",
              "    <tr style=\"text-align: right;\">\n",
              "      <th></th>\n",
              "      <th>x_distinct</th>\n",
              "      <th>x_min</th>\n",
              "      <th>x_max</th>\n",
              "      <th>y_distinct</th>\n",
              "      <th>y_min</th>\n",
              "      <th>y_max</th>\n",
              "    </tr>\n",
              "  </thead>\n",
              "  <tbody>\n",
              "    <tr>\n",
              "      <td>0</td>\n",
              "      <td>64</td>\n",
              "      <td>2</td>\n",
              "      <td>None</td>\n",
              "      <td>67</td>\n",
              "      <td>None</td>\n",
              "      <td>98</td>\n",
              "    </tr>\n",
              "  </tbody>\n",
              "</table>\n",
              "</div>"
            ],
            "text/plain": [
              "   x_distinct  x_min x_max  y_distinct y_min  y_max\n",
              "0          64      2  None          67  None     98"
            ]
          },
          "execution_count": 193,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "# multiple aggregation (multiple) by name and function\n",
        "d = df.cols.get('x', 'y').agg({\n",
        "    'x':['distinct', F.min], \n",
        "    'y':['distinct', 'max']})\n",
        "\n",
        "d.data.grid()"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 194,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/html": [
              "<div>\n",
              "<style scoped>\n",
              "    .dataframe tbody tr th:only-of-type {\n",
              "        vertical-align: middle;\n",
              "    }\n",
              "\n",
              "    .dataframe tbody tr th {\n",
              "        vertical-align: top;\n",
              "    }\n",
              "\n",
              "    .dataframe thead th {\n",
              "        text-align: right;\n",
              "    }\n",
              "</style>\n",
              "<table border=\"1\" class=\"dataframe\">\n",
              "  <thead>\n",
              "    <tr style=\"text-align: right;\">\n",
              "      <th></th>\n",
              "      <th>_idx</th>\n",
              "      <th>distinct</th>\n",
              "      <th>min</th>\n",
              "      <th>max</th>\n",
              "    </tr>\n",
              "  </thead>\n",
              "  <tbody>\n",
              "    <tr>\n",
              "      <td>0</td>\n",
              "      <td>x</td>\n",
              "      <td>64</td>\n",
              "      <td>2.0</td>\n",
              "      <td>NaN</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>1</td>\n",
              "      <td>y</td>\n",
              "      <td>67</td>\n",
              "      <td>NaN</td>\n",
              "      <td>98.0</td>\n",
              "    </tr>\n",
              "  </tbody>\n",
              "</table>\n",
              "</div>"
            ],
            "text/plain": [
              "  _idx  distinct  min   max\n",
              "0    x        64  2.0   NaN\n",
              "1    y        67  NaN  98.0"
            ]
          },
          "execution_count": 194,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "# multiple aggregation (multiple) by name and function (stacked)\n",
        "d = df.cols.get('x', 'y').agg({\n",
        "    'x':['distinct', F.min], \n",
        "    'y':['distinct', 'max']}, stack=True)\n",
        "d.data.grid()"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 195,
      "metadata": {},
      "outputs": [],
      "source": [
        "# grouped by, multiple aggregation (multiple) by name and function (stacked)\n",
        "d = df.cols.get('x', 'y').groupby('g','n').agg({\n",
        "    'x':['distinct', F.min], \n",
        "    'y':['distinct', 'max']}, stack=True)\n",
        "d.data.grid()"
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        "### Extended list of aggregation\n",
        "\n",
        "An extended list of aggregation is available, both by name and by function in the datafaucet library"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 210,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/html": [
              "<div>\n",
              "<style scoped>\n",
              "    .dataframe tbody tr th:only-of-type {\n",
              "        vertical-align: middle;\n",
              "    }\n",
              "\n",
              "    .dataframe tbody tr th {\n",
              "        vertical-align: top;\n",
              "    }\n",
              "\n",
              "    .dataframe thead th {\n",
              "        text-align: right;\n",
              "    }\n",
              "</style>\n",
              "<table border=\"1\" class=\"dataframe\">\n",
              "  <thead>\n",
              "    <tr style=\"text-align: right;\">\n",
              "      <th></th>\n",
              "      <th>g</th>\n",
              "      <th>n</th>\n",
              "      <th>_idx</th>\n",
              "      <th>type</th>\n",
              "      <th>uniq</th>\n",
              "      <th>one</th>\n",
              "      <th>top3</th>\n",
              "    </tr>\n",
              "  </thead>\n",
              "  <tbody>\n",
              "    <tr>\n",
              "      <td>0</td>\n",
              "      <td>1</td>\n",
              "      <td>Stacy</td>\n",
              "      <td>x</td>\n",
              "      <td>int</td>\n",
              "      <td>23</td>\n",
              "      <td>67</td>\n",
              "      <td>{32: 2, 25: 2, 39: 2}</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>1</td>\n",
              "      <td>0</td>\n",
              "      <td>Stacy</td>\n",
              "      <td>x</td>\n",
              "      <td>int</td>\n",
              "      <td>16</td>\n",
              "      <td>74</td>\n",
              "      <td>{70: 1, 74: 1, 19: 1}</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>2</td>\n",
              "      <td>2</td>\n",
              "      <td>Sandra</td>\n",
              "      <td>x</td>\n",
              "      <td>int</td>\n",
              "      <td>10</td>\n",
              "      <td>40</td>\n",
              "      <td>{4: 2, 97: 2, 69: 1}</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>3</td>\n",
              "      <td>1</td>\n",
              "      <td>Sandra</td>\n",
              "      <td>x</td>\n",
              "      <td>int</td>\n",
              "      <td>13</td>\n",
              "      <td>52</td>\n",
              "      <td>{56: 1, 8: 1, 2: 1}</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>4</td>\n",
              "      <td>0</td>\n",
              "      <td>Sandra</td>\n",
              "      <td>x</td>\n",
              "      <td>int</td>\n",
              "      <td>13</td>\n",
              "      <td>79</td>\n",
              "      <td>{36: 2, 89: 1, 35: 1}</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>5</td>\n",
              "      <td>2</td>\n",
              "      <td>Stacy</td>\n",
              "      <td>x</td>\n",
              "      <td>int</td>\n",
              "      <td>20</td>\n",
              "      <td>45</td>\n",
              "      <td>{61: 1, 34: 2, 70: 1}</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>6</td>\n",
              "      <td>2</td>\n",
              "      <td>Stacy</td>\n",
              "      <td>y</td>\n",
              "      <td>int</td>\n",
              "      <td>13</td>\n",
              "      <td>98</td>\n",
              "      <td>{30: 2, 66: 2, 35: 2}</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>7</td>\n",
              "      <td>0</td>\n",
              "      <td>Stacy</td>\n",
              "      <td>y</td>\n",
              "      <td>int</td>\n",
              "      <td>13</td>\n",
              "      <td>57</td>\n",
              "      <td>{36: 1, 57: 1, 25: 1}</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>8</td>\n",
              "      <td>1</td>\n",
              "      <td>Sandra</td>\n",
              "      <td>y</td>\n",
              "      <td>int</td>\n",
              "      <td>16</td>\n",
              "      <td>79</td>\n",
              "      <td>{97: 2, 82: 2, 15: 3}</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>9</td>\n",
              "      <td>2</td>\n",
              "      <td>Sandra</td>\n",
              "      <td>y</td>\n",
              "      <td>int</td>\n",
              "      <td>14</td>\n",
              "      <td>40</td>\n",
              "      <td>{1: 1, 98: 1, 7: 1}</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>10</td>\n",
              "      <td>1</td>\n",
              "      <td>Stacy</td>\n",
              "      <td>y</td>\n",
              "      <td>int</td>\n",
              "      <td>17</td>\n",
              "      <td>76</td>\n",
              "      <td>{4: 2, 86: 2, 67: 1}</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>11</td>\n",
              "      <td>0</td>\n",
              "      <td>Sandra</td>\n",
              "      <td>y</td>\n",
              "      <td>int</td>\n",
              "      <td>15</td>\n",
              "      <td>24</td>\n",
              "      <td>{64: 1, 8: 1, 53: 2}</td>\n",
              "    </tr>\n",
              "  </tbody>\n",
              "</table>\n",
              "</div>"
            ],
            "text/plain": [
              "    g       n _idx type  uniq one                   top3\n",
              "0   1   Stacy    x  int    23  67  {32: 2, 25: 2, 39: 2}\n",
              "1   0   Stacy    x  int    16  74  {70: 1, 74: 1, 19: 1}\n",
              "2   2  Sandra    x  int    10  40   {4: 2, 97: 2, 69: 1}\n",
              "3   1  Sandra    x  int    13  52    {56: 1, 8: 1, 2: 1}\n",
              "4   0  Sandra    x  int    13  79  {36: 2, 89: 1, 35: 1}\n",
              "5   2   Stacy    x  int    20  45  {61: 1, 34: 2, 70: 1}\n",
              "6   2   Stacy    y  int    13  98  {30: 2, 66: 2, 35: 2}\n",
              "7   0   Stacy    y  int    13  57  {36: 1, 57: 1, 25: 1}\n",
              "8   1  Sandra    y  int    16  79  {97: 2, 82: 2, 15: 3}\n",
              "9   2  Sandra    y  int    14  40    {1: 1, 98: 1, 7: 1}\n",
              "10  1   Stacy    y  int    17  76   {4: 2, 86: 2, 67: 1}\n",
              "11  0  Sandra    y  int    15  24   {64: 1, 8: 1, 53: 2}"
            ]
          },
          "execution_count": 210,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "from datafaucet.spark import aggregations as A\n",
        "\n",
        "d = df.cols.get('x', 'y').groupby('g','n').agg([\n",
        "        'type',\n",
        "        ('uniq', A.distinct),\n",
        "        'one',\n",
        "        'top3',\n",
        "    ], stack=True)\n",
        "\n",
        "d.data.grid()"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": null,
      "metadata": {},
      "outputs": [],
      "source": []
    }
  ],
  "metadata": {
    "kernelspec": {
      "display_name": "Python 3",
      "language": "python",
      "name": "python3"
    },
    "language_info": {
      "codemirror_mode": {
        "name": "ipython",
        "version": 3
      },
      "file_extension": ".py",
      "mimetype": "text/x-python",
      "name": "python",
      "nbconvert_exporter": "python",
      "pygments_lexer": "ipython3",
      "version": "3.7.3"
    }
  },
  "nbformat": 4,
  "nbformat_minor": 4
}

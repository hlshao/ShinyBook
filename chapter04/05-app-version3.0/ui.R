# headerの設定
header <- dashboardHeader(title = "地図アプリ")

# sidebarの設定
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Dashboard",
             tabName = "tab_dashboard", icon = icon("dashboard")),
    menuItem("leafletの基本機能", icon = icon("th"),
             tabName = "leaflet_basic",
             menuSubItem("Basic", tabName = "tab_basic", icon = icon("envira")),
             menuSubItem("Distance App", tabName = "tab_distance", icon = icon("map-marker"))),
    menuItem("Prefectures", icon = icon("th"), tabName = "prefectures",
             menuSubItem("Table", tabName = "tab_table", icon = icon("table")),
             menuSubItem("Product", "tab_product", icon = icon("search")),
             menuSubItem("Clustering", tabName = "tab_clustering", icon = icon("line-chart"))
    )
  )
)

# bodyの設定
body <- dashboardBody(
  tabItems(
    tabItem("tab_dashboard", titlePanel("Shiny で作成した地図アプリです。"),
            h3("shinydashboardライブラリを使用しています。")),
    tabItem("tab_basic",
            box(leaflet() %>%
                  addTiles() %>%
                  addMarkers(lng = 139.7, lat = 35.7)),
            box(leaflet() %>%
                  addTiles() %>%
                  addMarkers(lng = 139.7, lat = 35.7) %>%
                  addCircles(lng = 139, lat = 35, radius = 5000))),
    tabItem("tab_distance",
            titlePanel("距離を図る"),
            sidebarLayout(
              sidebarPanel(
                textInput("search_word1", "ワード1", value="東京"),
                textInput("search_word2", "ワード2", value="千葉"),
                
                h4("実行に数秒時間がかかります。"),
                h4("APIがエラーを返す場合があるので、その際は時間を置いてお試しください。"),
                actionButton("submit_dist", "地図を描写")
              ),
              mainPanel(
                leafletOutput("plot_dist", width="100%", height = "900px")
              )
            )
    ),
    # 以下追加箇所
    tabItem("tab_table",
            DT::dataTableOutput("attribute_table")),
    tabItem("tab_product"),
    tabItem("tab_clustering")
  )
)

dashboardPage(
  header,
  sidebar,
  body
)
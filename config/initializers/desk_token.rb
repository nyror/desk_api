#TODO need to read config from SYSTEM ENV
consumer = OAuth::Consumer.new(
        "aj3jwH7eA6lBMYXxlQxp",
        "IiJ5IFrWlt2kxd2NsfAt9zDF6Gq2f92M0PNk5wgZ",
        :site => "https://lion.desk.com",
        :scheme => :header
)

DeskApi::Application.config.access_token = OAuth::AccessToken.from_hash(
        consumer,
        :oauth_token => "KcBdk5LzIlgE2Nfuk09H",
        :oauth_token_secret => "KDm3q7KcENl7Dwhq4HKcV0GsD5hcfrp88VBjVLk"
)

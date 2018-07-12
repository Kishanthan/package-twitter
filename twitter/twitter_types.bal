// Copyright (c) 2018 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

documentation {Struct to define the Twitter connector
    F{{accessToken}} - The access token of the Twitter account
    F{{accessTokenSecret}} - The access token secret of the Twitter account
    F{{clientId}} - The consumer key of the Twitter account
    F{{clientSecret}} - The consumer secret of the Twitter account
    F{{clientEndpoint}} - HTTP client endpoint
}
public type TwitterConnector object {
    public string accessToken;
    public string accessTokenSecret;
    public string clientId;
    public string clientSecret;
    public http:Client clientEndpoint = new;

    documentation {Update the authenticated user's current status (If you want to provide attachment, you can use
        mediaIds or attachmentUrl)
        P{{status}} - The text of status update
        R{{}} - If success, returns Status object, else returns TwitterError object.}
    public function tweet(string status, string... args) returns Status|TwitterError;

    documentation {Retweet a tweet
        P{{id}} - The numerical ID of the desired status
        R{{}} - If success, returns Status object, else returns TwitterError object.}
    public function retweet(int id) returns Status|TwitterError;

    documentation {Untweet a retweeted status
        P{{id}} - The numerical ID of the desired status
        R{{}} - If success, returns Status object, else returns TwitterError object.}
    public function unretweet(int id) returns Status|TwitterError;

    documentation {Search for tweets
        P{{queryStr}} - Query string to retrieve the related tweets
        R{{}} - If success, Status[] object, else returns TwitterError object.}
    public function search(string queryStr) returns Status[]|TwitterError;

    documentation {Retrive a single status
        P{{id}} - The numerical ID of the desired status
        R{{}} - If success, returns Status object, else returns TwitterError object.}
    public function showStatus(int id) returns Status|TwitterError;

    documentation {Distroy a status
        P{{id}} - The numerical ID of the desired status
        R{{}} - If success, returns Status object, else returns TwitterError object.}
    public function destroyStatus(int id) returns Status|TwitterError;

    documentation {Retrive closest trend locations
        P{{lat}} - Latitude of the location
        P{{long}} - Longitude of the location
        R{{}} - If success, returns Location[] object, else returns TwitterError object.}
    public function getClosestTrendLocations(float lat, float long) returns Location[]|TwitterError;

    documentation {Retrive top trends by place
        P{{locationId}} - Where On Earth ID of the location to return trending information for
        R{{}} - If success, returns Trends[] object, else returns TwitterError object.}
    public function getTopTrendsByPlace(int locationId) returns Trends[]|TwitterError;
};

documentation {Twitter Client object
    E{{}}
    F{{twitterConfig}} - Twitter connector configurations
    F{{twitterConnector}} - TwitterConnector Connector object
}
public type Client object {
    public TwitterConfiguration twitterConfig = {};
    public TwitterConnector twitterConnector = new;

    documentation {Twitter connector endpoint initialization function
        P{{config}} - Twitter connector configuration
    }
    public function init(TwitterConfiguration config);

    documentation {Return the Twitter connector client
        R{{}} - Twitter connector client
    }
    public function getCallerActions() returns TwitterConnector;

};

documentation {Twitter connector configurations can be setup here
    F{{uri}} - The Twitter API URL
    F{{accessToken}} - The access token of the Twitter account
    F{{accessTokenSecret}} - The access token secret of the Twitter account
    F{{clientId}} - The consumer key of the Twitter account
    F{{clientSecret}} - The consumer secret of the Twitter account
    F{{clientConfig}} - Client endpoint configurations provided by the user
}
public type TwitterConfiguration record {
    string uri;
    string accessToken;
    string accessTokenSecret;
    string clientId;
    string clientSecret;
    http:ClientEndpointConfig clientConfig = {};
};

documentation {Struct to define the status
    F{{createdAt}} - Created time of the status
    F{{id}} - Id of the status
    F{{text}} - Text message of the status
    F{{source}} - Source app of the status
    F{{truncated}} - Whether the status is truncated or not
    F{{inReplyToStatusId}} - The ID of an existing status that the update is in reply to
    F{{geo}} - Geo location details (longitude and latitude)
    F{{favorited}} - Whether the status is favorited or not
    F{{retweeted}} - Whether the status is retweeted or not
    F{{favouritesCount}} - Count of the favourites
    F{{retweetCount}} - Count of the retweeted status
    F{{lang}} - Language
}
public type Status record {
    string createdAt;
    int id;
    string text;
    string source;
    boolean truncated;
    int inReplyToStatusId;
    GeoLocation geo;
    boolean favorited;
    boolean retweeted;
    int favouritesCount;
    int retweetCount;
    string lang;
};

documentation {Struct to define the geo location details
    F{{latitude}} - Latitude of the location
    F{{longitude}} - Longitude of the location
}
public type GeoLocation record {
    float latitude;
    float longitude;
};

documentation {Struct to define the location details
    F{{woeid}} - Where On Earth IDentifier
    F{{countryName}} - Country name
    F{{countryCode}} - Country code
    F{{name}} - Name of the location
    F{{placeType}} - Longitude of the location
    F{{url}} - Location url
}
public type Location record {
    int woeid;
    string countryName;
    string countryCode;
    string name;
    PlaceType placeType;
    string url;
};

documentation {Struct to define the place type
    F{{name}} - Name of the place
    F{{code}} - Location code of the place
}
public type PlaceType record {
    string name;
    int code;
};

documentation {Struct to define the trends type
    F{{trends}} - List of Trending object
    F{{locations}} - List of Locations object
    F{{createdAt}} - Created time
}
public type Trends record {
    Trend[] trends;
    Location[] locations;
    string createdAt;
};

documentation {Struct to define the trend type
    F{{name}} - Name of trend object
    F{{url}} - Url of trend object
    F{{trendQuery}} - Query of the trend object
    F{{promotedContent}} - Promoted content
    F{{tweetVolume}} - Volume of the tweet
}
public type Trend record {
    string name;
    string url;
    string trendQuery;
    string promotedContent;
    int tweetVolume;
};

documentation {Struct to define the error
    F{{message}} - Error message of the response
    F{{cause}} - The error which caused the Twitter error
    F{{statusCode}} - Status code of the response
}
public type TwitterError record {
    string message;
    error? cause;
    int statusCode;
};

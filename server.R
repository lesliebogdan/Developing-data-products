library(shiny)
library(leaflet)
library(lubridate)
library(caret)
library(leaflet)
library(RCurl)
library(rio)
library(readr)



        
shinyServer(
        function(input, output, session) {
######################################

                
                SmallIcon <- makeIcon(
                        iconUrl = 
                                "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAGd0lEQVRYR8WXCUwUdxTGv5k9uPcA9gA5BUpFQWij1gurtUANwQttifVsIiKFYGoaiTU9tNGkpkVFxJBq1cRaq0I9KyFa1BIV0VawClVAwcqKICDn7s5M82YXpFUW3Mb0H2Bh2XnvN+/43hsG//Nh7PAvT8tJ7DFzJvA8J17OMBLIpDJsW3nIAYDxRWzaA6BesTWheeMHeeBEAAESVoLMb5cjN/2oO4DHLwuAXb45YSEk/Bdmwey3OHYFTpXthwABy6atwaYfMiGTyMGwDCAw5eCFvTtXHfsaAG8LaCgRYJasjw92VLDF/rogrzfCpmKEfyTuNNxA4bX9ou2YyCQEeY0CGes2dqH6QSWq6itQXnMF2alHbKZlMADm3cy3QlReLpWzJi5AmP9o3Kq/iqr6q+DAob2rTXTq6qTE4/ZGyGUO8HDVI0A/EuH+Y7Fh32rkpOXbTMtgAA4pW2e2JUxIkvto/XD8yi6YOTNYVgKGYcEyrBgBSgME8ScEgRf/NhnNMBjaHuZmFIQDeDhQGmwBsEu/fCczYkTUhrfHxuNE2R6x6kXnYMCyDBiGgclkhkwmtYAIhGA5ra0duHu78dDez04lA2i2B8B5RdbM6sVxqbrL1SfRZezoc06F9qS1Cy1tHeD5p04dHWRwdnaASuGEhsZWVJTUpJ7IK9kH4Ik9AO4rt81uWhCzGL9WngDLSMU7poCbzGbcvffItCM9PwGAyWqcmTI/cmzACO84pc51Mn10S8rBYAB1trTBVgq0qdlzDFPGTERd4+2n+RZ4hHpH4WJFGerv1xUf+Orswq7mrh4AEgAuAJRUlwA6ANQCaBKpBzg2AT7MTjREhYfiSWcL6Z1oghd4sdLHh8Tj4s1ilFaWwNjTfcZoxDe7Pz5WBEBu/SaVIgibymgTIG37PEPwcB1Ylu0rMCo0XuCgVfphtF80WIkUVXU3UFF9DXUP7wI8u3HnqoJ1ACw6PcixBeCZtDZmc1CYfrGP3h0cLzwDQSA+7q/ASxUAL/VwtHW24ML1s7hR+xs4E7s076OCvf9FCSmfgSlZc4q9vNXuOq0SPM+LEL3dRumgvqdXR5kLfN1DEKQbDUPzXzh87nsYu027clcVLLcVDVsRoKIiFRu+fPOsA+4ergF6vQouzg6W1hNBesWHXi0w1C0R/tGQMs44ULQbjw3tiXs+PZk/UCQGU0IZAE8APnHLxs0LjvLNkDtIZRpPNyiVLpDJJCIETyERvwiKIsIh3HcyDI3NOFNaeDM3o+A1GhPPK4fBAOgagnADoAXgETzaJ3D87PBkpafLJBdXR3jrVXB1cQTPkQRbjiU1HF4PiMPu43nYkV6gBkCt9MwZCgBdRKJPU43qgnqcDKpiFo2JCRnjv4Y6Ral06qeKYiwwTB2EwgsXkJVygOAb7QGQpmyZm89K+HjOzG/KzfjpEyuMEwBnqpFxM0ZOnTIvMjvs1WHguP6jX4DCWY1blQ1Yl5StG2gg2RxGSzbEzQ0NCT0YOyEe56+dxR/V5WAEyY8mE7+L6zTe+i7r55b5ydPWhoWHrg4McgXfzz9JsVTKouTin8hJP2IXgHzZxhl50eOmLvLxVkCnCBaLraL6OuoNdWjraEV3Tw80ai0mREzGneYSmpF9UaZpSRG5dOl2Y+6q/FH2RMAtOWtmVXz0DH2TsRIMI4XayQsaN18onDT/SKehrRr3mm6AZahzaUllIJGwqL/fhMvFlVmHvv5l/UAj2VYK3Fdum9P0fkIiahp/h8Bb201sNQFOcoXorMvY1m85sewIdPfdXSaUXq025aQfjrQOpc4XLUJt2vZEQ3CgL7Q6J9EoCZBFCS1VLvYdQ+sJOaZfWUhYBp3dRly9VovCPZcSb126ex7AI3uESK0L8oiKXTTmc5VGMclT4waNhwI6jZsIwvF8X9sRHIW8vcOIe/WP0PCgxVS0r2xhVWntRQANAGhcP/fYSgGNVQ8Aeur5hNTo97T+qulyR9lwM8cjdnp4X9uR88Kicggc39BQ8/jo0e3naAjVAzBYndu1DxAxLXvU8yQ+KuuyoUjdlnh6RmwEzGaLXamUwcnT17E97dCb1mqnJaTVugsM6Fws2MHmtfX/vUroCECTnjO/klJAhSkaoRSwLLauPBgE4IH1rm0+kPT6HSpAf06S4UCrHPd/nx7Jal7mo1mvM6oNmgk0pPofWk4HXcH+HXF7IjDErA3tY38D1WOaP6r+fasAAAAASUVORK5CYII=",
                       iconWidth = 20, iconHeight = 20,
                        iconAnchorX = 20, iconAnchorY = 20
                )
                MediumIcon <- makeIcon(
                        iconUrl = 
                                "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAGd0lEQVRYR8WXCUwUdxTGv5k9uPcA9gA5BUpFQWij1gurtUANwQttifVsIiKFYGoaiTU9tNGkpkVFxJBq1cRaq0I9KyFa1BIV0VawClVAwcqKICDn7s5M82YXpFUW3Mb0H2Bh2XnvN+/43hsG//Nh7PAvT8tJ7DFzJvA8J17OMBLIpDJsW3nIAYDxRWzaA6BesTWheeMHeeBEAAESVoLMb5cjN/2oO4DHLwuAXb45YSEk/Bdmwey3OHYFTpXthwABy6atwaYfMiGTyMGwDCAw5eCFvTtXHfsaAG8LaCgRYJasjw92VLDF/rogrzfCpmKEfyTuNNxA4bX9ou2YyCQEeY0CGes2dqH6QSWq6itQXnMF2alHbKZlMADm3cy3QlReLpWzJi5AmP9o3Kq/iqr6q+DAob2rTXTq6qTE4/ZGyGUO8HDVI0A/EuH+Y7Fh32rkpOXbTMtgAA4pW2e2JUxIkvto/XD8yi6YOTNYVgKGYcEyrBgBSgME8ScEgRf/NhnNMBjaHuZmFIQDeDhQGmwBsEu/fCczYkTUhrfHxuNE2R6x6kXnYMCyDBiGgclkhkwmtYAIhGA5ra0duHu78dDez04lA2i2B8B5RdbM6sVxqbrL1SfRZezoc06F9qS1Cy1tHeD5p04dHWRwdnaASuGEhsZWVJTUpJ7IK9kH4Ik9AO4rt81uWhCzGL9WngDLSMU7poCbzGbcvffItCM9PwGAyWqcmTI/cmzACO84pc51Mn10S8rBYAB1trTBVgq0qdlzDFPGTERd4+2n+RZ4hHpH4WJFGerv1xUf+Orswq7mrh4AEgAuAJRUlwA6ANQCaBKpBzg2AT7MTjREhYfiSWcL6Z1oghd4sdLHh8Tj4s1ilFaWwNjTfcZoxDe7Pz5WBEBu/SaVIgibymgTIG37PEPwcB1Ylu0rMCo0XuCgVfphtF80WIkUVXU3UFF9DXUP7wI8u3HnqoJ1ACw6PcixBeCZtDZmc1CYfrGP3h0cLzwDQSA+7q/ASxUAL/VwtHW24ML1s7hR+xs4E7s076OCvf9FCSmfgSlZc4q9vNXuOq0SPM+LEL3dRumgvqdXR5kLfN1DEKQbDUPzXzh87nsYu027clcVLLcVDVsRoKIiFRu+fPOsA+4ergF6vQouzg6W1hNBesWHXi0w1C0R/tGQMs44ULQbjw3tiXs+PZk/UCQGU0IZAE8APnHLxs0LjvLNkDtIZRpPNyiVLpDJJCIETyERvwiKIsIh3HcyDI3NOFNaeDM3o+A1GhPPK4fBAOgagnADoAXgETzaJ3D87PBkpafLJBdXR3jrVXB1cQTPkQRbjiU1HF4PiMPu43nYkV6gBkCt9MwZCgBdRKJPU43qgnqcDKpiFo2JCRnjv4Y6Ral06qeKYiwwTB2EwgsXkJVygOAb7QGQpmyZm89K+HjOzG/KzfjpEyuMEwBnqpFxM0ZOnTIvMjvs1WHguP6jX4DCWY1blQ1Yl5StG2gg2RxGSzbEzQ0NCT0YOyEe56+dxR/V5WAEyY8mE7+L6zTe+i7r55b5ydPWhoWHrg4McgXfzz9JsVTKouTin8hJP2IXgHzZxhl50eOmLvLxVkCnCBaLraL6OuoNdWjraEV3Tw80ai0mREzGneYSmpF9UaZpSRG5dOl2Y+6q/FH2RMAtOWtmVXz0DH2TsRIMI4XayQsaN18onDT/SKehrRr3mm6AZahzaUllIJGwqL/fhMvFlVmHvv5l/UAj2VYK3Fdum9P0fkIiahp/h8Bb201sNQFOcoXorMvY1m85sewIdPfdXSaUXq025aQfjrQOpc4XLUJt2vZEQ3CgL7Q6J9EoCZBFCS1VLvYdQ+sJOaZfWUhYBp3dRly9VovCPZcSb126ex7AI3uESK0L8oiKXTTmc5VGMclT4waNhwI6jZsIwvF8X9sRHIW8vcOIe/WP0PCgxVS0r2xhVWntRQANAGhcP/fYSgGNVQ8Aeur5hNTo97T+qulyR9lwM8cjdnp4X9uR88Kicggc39BQ8/jo0e3naAjVAzBYndu1DxAxLXvU8yQ+KuuyoUjdlnh6RmwEzGaLXamUwcnT17E97dCb1mqnJaTVugsM6Fws2MHmtfX/vUroCECTnjO/klJAhSkaoRSwLLauPBgE4IH1rm0+kPT6HSpAf06S4UCrHPd/nx7Jal7mo1mvM6oNmgk0pPofWk4HXcH+HXF7IjDErA3tY38D1WOaP6r+fasAAAAASUVORK5CYII=",
                        iconWidth = 40, iconHeight = 40,
                        iconAnchorX = 40, iconAnchorY = 40
                )
                LargeIcon <- makeIcon(
                        iconUrl = 
                                "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAGd0lEQVRYR8WXCUwUdxTGv5k9uPcA9gA5BUpFQWij1gurtUANwQttifVsIiKFYGoaiTU9tNGkpkVFxJBq1cRaq0I9KyFa1BIV0VawClVAwcqKICDn7s5M82YXpFUW3Mb0H2Bh2XnvN+/43hsG//Nh7PAvT8tJ7DFzJvA8J17OMBLIpDJsW3nIAYDxRWzaA6BesTWheeMHeeBEAAESVoLMb5cjN/2oO4DHLwuAXb45YSEk/Bdmwey3OHYFTpXthwABy6atwaYfMiGTyMGwDCAw5eCFvTtXHfsaAG8LaCgRYJasjw92VLDF/rogrzfCpmKEfyTuNNxA4bX9ou2YyCQEeY0CGes2dqH6QSWq6itQXnMF2alHbKZlMADm3cy3QlReLpWzJi5AmP9o3Kq/iqr6q+DAob2rTXTq6qTE4/ZGyGUO8HDVI0A/EuH+Y7Fh32rkpOXbTMtgAA4pW2e2JUxIkvto/XD8yi6YOTNYVgKGYcEyrBgBSgME8ScEgRf/NhnNMBjaHuZmFIQDeDhQGmwBsEu/fCczYkTUhrfHxuNE2R6x6kXnYMCyDBiGgclkhkwmtYAIhGA5ra0duHu78dDez04lA2i2B8B5RdbM6sVxqbrL1SfRZezoc06F9qS1Cy1tHeD5p04dHWRwdnaASuGEhsZWVJTUpJ7IK9kH4Ik9AO4rt81uWhCzGL9WngDLSMU7poCbzGbcvffItCM9PwGAyWqcmTI/cmzACO84pc51Mn10S8rBYAB1trTBVgq0qdlzDFPGTERd4+2n+RZ4hHpH4WJFGerv1xUf+Orswq7mrh4AEgAuAJRUlwA6ANQCaBKpBzg2AT7MTjREhYfiSWcL6Z1oghd4sdLHh8Tj4s1ilFaWwNjTfcZoxDe7Pz5WBEBu/SaVIgibymgTIG37PEPwcB1Ylu0rMCo0XuCgVfphtF80WIkUVXU3UFF9DXUP7wI8u3HnqoJ1ACw6PcixBeCZtDZmc1CYfrGP3h0cLzwDQSA+7q/ASxUAL/VwtHW24ML1s7hR+xs4E7s076OCvf9FCSmfgSlZc4q9vNXuOq0SPM+LEL3dRumgvqdXR5kLfN1DEKQbDUPzXzh87nsYu027clcVLLcVDVsRoKIiFRu+fPOsA+4ergF6vQouzg6W1hNBesWHXi0w1C0R/tGQMs44ULQbjw3tiXs+PZk/UCQGU0IZAE8APnHLxs0LjvLNkDtIZRpPNyiVLpDJJCIETyERvwiKIsIh3HcyDI3NOFNaeDM3o+A1GhPPK4fBAOgagnADoAXgETzaJ3D87PBkpafLJBdXR3jrVXB1cQTPkQRbjiU1HF4PiMPu43nYkV6gBkCt9MwZCgBdRKJPU43qgnqcDKpiFo2JCRnjv4Y6Ral06qeKYiwwTB2EwgsXkJVygOAb7QGQpmyZm89K+HjOzG/KzfjpEyuMEwBnqpFxM0ZOnTIvMjvs1WHguP6jX4DCWY1blQ1Yl5StG2gg2RxGSzbEzQ0NCT0YOyEe56+dxR/V5WAEyY8mE7+L6zTe+i7r55b5ydPWhoWHrg4McgXfzz9JsVTKouTin8hJP2IXgHzZxhl50eOmLvLxVkCnCBaLraL6OuoNdWjraEV3Tw80ai0mREzGneYSmpF9UaZpSRG5dOl2Y+6q/FH2RMAtOWtmVXz0DH2TsRIMI4XayQsaN18onDT/SKehrRr3mm6AZahzaUllIJGwqL/fhMvFlVmHvv5l/UAj2VYK3Fdum9P0fkIiahp/h8Bb201sNQFOcoXorMvY1m85sewIdPfdXSaUXq025aQfjrQOpc4XLUJt2vZEQ3CgL7Q6J9EoCZBFCS1VLvYdQ+sJOaZfWUhYBp3dRly9VovCPZcSb126ex7AI3uESK0L8oiKXTTmc5VGMclT4waNhwI6jZsIwvF8X9sRHIW8vcOIe/WP0PCgxVS0r2xhVWntRQANAGhcP/fYSgGNVQ8Aeur5hNTo97T+qulyR9lwM8cjdnp4X9uR88Kicggc39BQ8/jo0e3naAjVAzBYndu1DxAxLXvU8yQ+KuuyoUjdlnh6RmwEzGaLXamUwcnT17E97dCb1mqnJaTVugsM6Fws2MHmtfX/vUroCECTnjO/klJAhSkaoRSwLLauPBgE4IH1rm0+kPT6HSpAf06S4UCrHPd/nx7Jal7mo1mvM6oNmgk0pPofWk4HXcH+HXF7IjDErA3tY38D1WOaP6r+fasAAAAASUVORK5CYII=",
                        iconWidth = 70, iconHeight = 70,
                        iconAnchorX = 70, iconAnchorY = 70
                )
                
                #input$recalc
observeEvent(input$recalc,{
                
        df_original<-read_csv("https://raw.githubusercontent.com/lesliebogdan/Developing-data-products/master/chicago_taxi_trips_2016_01_cutdown_final.csv")
        
        ####
        # Stripe out un wanted columns
        ####
        
        df_clean<-subset(df_original,select = -c(pickup_census_tract,dropoff_census_tract,company,pickup_latitude,pickup_longitude,dropoff_latitude,dropoff_longitude)
        )
        #####
        # Cleaning
        #####
        
        #
        df_clean<-subset(df_clean,dropoff_community_area!="NA")
        #
        df_clean<-subset(df_clean,pickup_community_area!="NA")
        # 
        df_clean<-subset(df_clean,trip_seconds!="NA")
        # 
        df_clean<-subset(df_clean,trip_miles!="NA")
        # 
        df_clean<-subset(df_clean,fare!="NA")
        
        # Change area codes to factors for regression
        
        df_clean$pickup_community_area<-as.factor(df_clean$pickup_community_area)
        df_clean$dropoff_community_area<-as.factor(df_clean$dropoff_community_area)
        df_clean$payment_type<-as.factor(df_clean$payment_type)
        
        ####
        # Add in additional mark ups and lookups
        ####
        
        # Add in the long and lat for each of the 'dropoff_community_area
        
        # Day of week to be determined
        
        day_of_week<-as.factor(weekdays(as.Date(df_clean$trip_end_timestamp)))
        
        # Recombine new columns
        
        df_clean<-cbind(df_clean,day_of_week)
        
        
        df_cut<-subset(df_clean,select = c(hour,fare,day_of_week,payment_type,pickup_community_area,trip_miles,tips))
        
        df_cut$hour<-as.factor(df_cut$hour)
        
        model<-lm(tips~.,df_cut)
        
        
        # Creating the Map components 
        
        df_locations<-read_csv("https://raw.githubusercontent.com/lesliebogdan/Developing-data-products/master/chicago_locations_cutdown.csv")
        
       # rm(my_map)
        
 #       my_map<-leaflet()
#        my_map<-addTiles(my_map)
       # my_map<-addMarkers(my_map,lat = df_locations$lat,lng=df_locations$lng,popup = paste(df_locations$Name,"(",df_locations$community_area,")"))
      #  my_map
        
        les_test3<-array(1,dim=6)
        
        
#        les_test<-predict(model,c(as.factor(6),as.numeric(4),as.factor("Sunday"),as.factor("Cash"),as.factor("24"),as.numeric(4)))
        les_test1<-data.frame(as.factor(input$hour),as.numeric(input$trip_miles),as.factor(input$day_of_week),as.factor(input$payment_type),as.factor("24"),as.numeric(input$trip_miles))
        names(les_test1)<-c('hour','fare','day_of_week','payment_type','pickup_community_area','trip_miles')
        
        les_test2<-data.frame(as.factor(input$hour),as.numeric(input$trip_miles),as.factor(input$day_of_week),as.factor(input$payment_type),as.factor("28"),as.numeric(input$trip_miles))
        names(les_test2)<-c('hour','fare','day_of_week','payment_type','pickup_community_area','trip_miles')
        
        les_test3<-data.frame(as.factor(input$hour),as.numeric(input$trip_miles),as.factor(input$day_of_week),as.factor(input$payment_type),as.factor("32"),as.numeric(input$trip_miles))
        names(les_test3)<-c('hour','fare','day_of_week','payment_type','pickup_community_area','trip_miles')
        
        les_test4<-data.frame(as.factor(input$hour),as.numeric(input$trip_miles),as.factor(input$day_of_week),as.factor(input$payment_type),as.factor("7"),as.numeric(input$trip_miles))
        names(les_test4)<-c('hour','fare','day_of_week','payment_type','pickup_community_area','trip_miles')
        
        les_test5<-data.frame(as.factor(input$hour),as.numeric(input$trip_miles),as.factor(input$day_of_week),as.factor(input$payment_type),as.factor("6"),as.numeric(input$trip_miles))
        names(les_test5)<-c('hour','fare','day_of_week','payment_type','pickup_community_area','trip_miles')
        
        les_test6<-data.frame(as.factor(input$hour),as.numeric(input$trip_miles),as.factor(input$day_of_week),as.factor(input$payment_type),as.factor("76"),as.numeric(input$trip_miles))
        names(les_test6)<-c('hour','fare','day_of_week','payment_type','pickup_community_area','trip_miles')
        
        les_test7<-data.frame(as.factor(input$hour),as.numeric(input$trip_miles),as.factor(input$day_of_week),as.factor(input$payment_type),as.factor("8"),as.numeric(input$trip_miles))
        names(les_test7)<-c('hour','fare','day_of_week','payment_type','pickup_community_area','trip_miles')
        
        les_test8<-data.frame(as.factor(input$hour),as.numeric(input$trip_miles),as.factor(input$day_of_week),as.factor("Cash"),as.factor("Other"),as.numeric(input$trip_miles))
        names(les_test8)<-c('hour','fare','day_of_week','payment_type','pickup_community_area','trip_miles')
        
        les_test_total<-rbind(les_test1,les_test2,les_test3,les_test4,les_test5,les_test6,les_test7,les_test8)
        
        #names(les_test_total)<-c('hour','fare','day_of_week','payment_type','pickup_community_area','trip_miles')
        
        outcome<-predict(model,les_test_total)
        
       color_set=c('SmallIcon','SmallIcon','SmallIcon','SmallIcon','SmallIcon','SmallIcon','SmallIcon','SmallIcon')
        
        for (i in 1:8) {
                if(outcome[i]<0) {
                        outcome[i]<-0
                }
                else{
                        
                }
                next
        }
        
        for (i in 1:8) {
                if(outcome[i]==0){
                        color_set[i]<-'red'
                }
                else if(outcome[i]>0 & outcome[i]<=1){
                        color_set[i]<-'orange'
                }
                else if(outcome[i]>1){
                        color_set[i]<-'green'
                }
                next
        }
        
######################################

        
        
        
        observe({
                event <- input$myMap_shape_click
                if (is.null(event))
                        return()
                print(event)      
        })
        
        points <- eventReactive(input$recalc, {
                cbind(df_locations$lat,df_locations$lng)
        }, ignoreNULL = FALSE)
        
        output$mymap <- renderLeaflet({
                leaflet() %>%
                        addTiles(
                        ) %>%
                     
                        #addCircleMarkers(lat = df_locations$lat,lng=df_locations$lng,radius = 15,color=color_set,popup = paste(df_locations$Name,"(",df_locations$community_area,")"))
                        addCircleMarkers(lat = df_locations$lat,lng=df_locations$lng,fillColor=color_set,fill=TRUE,color='black',fillOpacity=1,opacity=0.5,
                                         options = popupOptions(closeButton = FALSE),weight=1,popup = paste(df_locations$Name,"(",df_locations$community_area,")")) 
                     
                        
                       
                        
                 })
        
        output$tip1 <- renderText({paste('$',round(outcome[1],digits = 2))})
        output$tip2 <- renderText({paste('$',round(outcome[2],digits = 2))})
        output$tip3 <- renderText({paste('$',round(outcome[3],digits = 2))})
        output$tip4 <- renderText({paste('$',round(outcome[4],digits = 2))})
        output$tip5 <- renderText({paste('$',round(outcome[5],digits = 2))})
        output$tip6 <- renderText({paste('$',round(outcome[6],digits = 2))})
        output$tip7 <- renderText({paste('$',round(outcome[7],digits = 2))})
        output$tip8 <- renderText({paste('$',round(outcome[8],digits = 2))})
      
        
        outcome_rounded<-paste('$',round(outcome,2))
        
        df_result<-data.frame(cbind(outcome_rounded,df_locations$Name))
        
        names(df_result)<-c("Tip Prediction (per mile)","Area")
        
        output$table<-renderTable(df_result)

})
        }
)
#shinyApp(ui, server)
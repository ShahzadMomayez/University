#ifndef _UTAX_
#define _UTAX_

#include <iostream>
#include <string>
#include <vector>
#include <stdexcept>
#include <cmath>
#include "person.hpp"
#include "trip.hpp"

class UTax{
    private:
        std::vector<Trip *> trips;
        std::vector<Person *> members;
        std::vector<Place> places;
        int last_trip_id;
        bool hurry;
    public:
        UTax(std::vector<Place> places_){
            places = places_;
            last_trip_id = 0;
        };
        void signup(std::string name , std::string role);
        void trip(std::string origin, std::string destination, std::string passenger , bool is_hurry);
        bool have_trip(std::string passenger_name , std::string origin , std::string destination);
        std::vector<Trip *> get_trips(std::string requester);
        Trip * get_trip(std::string requester, int trip_id);
        void delete_trip(std::string requester, int trip_id); 
        void accept_trip(std::string requester, int trip_id);
        void finish_trip(std::string requester, int trip_id);
        double find_trip_cost(std::string origin, std::string destination , bool is_hurry);
        int get_last_trip_id(){
            return last_trip_id;
        }
        std::vector<Person *> get_members(){
            return members;
        }
        std::vector<Place> get_places(){
            return places;
        }
};

#endif

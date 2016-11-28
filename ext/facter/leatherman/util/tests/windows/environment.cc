#include <catch.hpp>
#include <leatherman/util/environment.hpp>
#include <leatherman/windows/windows.hpp>
#include <unistd.h>

using namespace std;
using namespace leatherman::util;

SCENARIO("path separator on Windows") {
    REQUIRE(environment::get_path_separator() == ';');
}

SCENARIO("environment search paths") {
    GIVEN("paths from the environment") {
        auto paths = environment::search_paths();
        REQUIRE(paths.size() > 0u);
    }
    GIVEN("empty paths from the environment") {
        string value;
        REQUIRE(environment::get("PATH", value));
        REQUIRE(environment::set("PATH", value+";"));
        environment::reload_search_paths();
        auto paths = environment::search_paths();
        THEN("an empty path should not be searched") {
            REQUIRE(count(paths.begin(), paths.end(), "") == 0);
        }
        REQUIRE(environment::set("PATH", value));
        environment::reload_search_paths();
    }
}

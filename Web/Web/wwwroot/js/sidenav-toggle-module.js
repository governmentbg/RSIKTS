let sideNavModule = (function () {

    const closeNav = function () {
        document.getElementById("mySidenav").style.width = "0";
        document.getElementById("sidenav-ico").style = "transform:rotate(0deg);";
    };

    const openNav = function () {
        if (document.getElementById("mySidenav").style.width === "" ||
            document.getElementById("mySidenav").style.width === "0px") {
            if (window.innerWidth <= 576) {
                document.getElementById("mySidenav").style.width = "100%";
            } else {
                document.getElementById("mySidenav").style.width = "300px";
            }

            document.getElementById("sidenav-ico").style = "transform:rotate(180deg);";
        } else {
            closeNav();
        }
    };

    return {
        CloseNav: function() {
            return closeNav();
        },
        OpenNav: function() {
            return openNav();
        }
    };

})();
var cls = "";
function onbodyload() {
    var txtArray = document.getElementsByTagName("input");
    var txtArray1 = document.getElementsByTagName("textarea");
    for (var i = 0; i < txtArray.length; i++) {
        if (txtArray[i].type == "text") {
            cls = txtArray[i].className.replace("Gray", "");
            if ((txtArray[i].value == "" || txtArray[i].value == txtArray[i].title) && txtArray[i].title != "") {
                txtArray[i].value = txtArray[i].title;
                txtArray[i].className = cls + "Gray";
            }
            else {
                txtArray[i].className = cls;
            }
        }
    }

    for (var i = 0; i < txtArray1.length; i++) {
        cls = txtArray1[i].className.replace("Gray", "");
        if ((txtArray1[i].value == "" || txtArray1[i].value == txtArray1[i].title) && txtArray1[i].title != "") {
            txtArray1[i].value = txtArray1[i].title;
            txtArray1[i].className = cls + "Gray";
        }
        else {
            txtArray1[i].className = cls;
        }
    }
};

function txtOnFocus(ctl, cls) {
    if (ctl.value == ctl.title) {
        ctl.className = cls;
        ctl.value = "";
    }
};

function txtOnLeave(ctl, cls) {
    if (ctl.value == "" && ctl.title != "") {
        ctl.className = cls + "Gray";
        ctl.value = ctl.title;
    }
};
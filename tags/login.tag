<login>
  <!-- HTML -->
  <button show={ !user } class="btn btn-outline-success my-2 my-sm-0" type="button" onclick={ login }>Login</button>
  <button show={ user } class="btn btn-outline-danger my-2 my-sm-0" type="button" onclick={ logout }>Logout</button>
  <div show={ user }>
    <!-- if user signin shows them their homepage -->
    <home></home>
    <create></create>
    <pickMonster></pickMonster>
  </div>
  <script>
    // JAVASCRIPT
    this.user;

    // //set up database
    let database = firebase.firestore();

    login() {
			var provider = new firebase.auth.GoogleAuthProvider();
			firebase.auth().signInWithPopup(provider);
		}
		logout() {
			firebase.auth().signOut();
		}

    // Firebase authentication state listener
		firebase.auth().onAuthStateChanged(userObj => {
		  if (userObj) {
		    this.user = userObj;
				// start data listening
        stopListening = database.collection('Users').onSnapshot(snapshot => {
					snapshot.forEach(doc => {
            let userInfo = {
              id: firebase.auth().currentUser.uid,
              name: firebase.auth().currentUser.displayName,
              email: firebase.auth().currentUser.email
            };
             database.collection('Users').doc(firebase.auth().currentUser.uid).set(userInfo);
					});
					this.update();
		    })
      }
      else {
		    this.user = null;
				stopListening();
		  }
			this.update();
		});
  </script>

  <style>
    /* CSS */
    :scope {}
    .special {
      background-color: #333333;
      color: #FFFFFF;
    }
  </style>
</login>

import Home from "./pages/home.imba"
import Add from "./pages/add.imba"
import Groups from "./pages/groups.imba"
import User from "./pages/user.imba"

global css @root
	$black: #333 $blue: #264653 $green: #2a9d8f $yellow: #e9c46a $orange: #f4a261 $red: #e76f51 $gray: #eae8e8
global css html,body m:0 p:0 w:100% h:100% ff:sans
global css * box-sizing: border-box -webkit-tap-highlight-color: transparent
global css h2 my:10px
	@lt-sm fs:md

tag Layout
	<self>
		css w:100% h:100%
		<App>
		<Navbar>

tag App
	css w:100% h:100%
	<self>
		<Home route="/home">
		<Add route="/add">
		<Groups route="/groups">
		<User route="/user">

tag Navbar
	<self>
		css w:100% h:80px bg:$gray d:flex ai:center jc:space-evenly pos:relative b:0 pos:fixed w:100%
		<NavLink route-to="/home"> <i.fa-solid.fa-burger>
		<NavLink route-to="/add"> <i.fa-solid.fa-circle-plus>
		<NavLink route-to="/groups"> <i.fa-solid.fa-users>
		<NavLink route-to="/user"> <i.fa-solid.fa-user>
		<Slider route="/:site">

tag NavLink < button
	<self>
		css w:20% h:50px d:flex ai:center jc:center td:none color:$black fs:3xl tween:all 50ms linear bg:transparent bd:none cursor:pointer
			&.active color:$green
			@active scale: 0.8
			@media(hover: hover)@hover o:0.8
		<slot>

tag Slider
	prop offsetX = 4vw;
	def routed params
		let offsets = {"home": 4vw, "add": 28vw, "groups": 52vw, "user": 76vw};
		offsetX = offsets[params.site];

	<self [x: {offsetX}]>
		css w:20% h:30px rd:5px pos:absolute bg: $green bottom: -20px l:0 x:4vw tween:transform 0.1s ease


imba.router.alias("/", "/home")
imba.mount <Layout>
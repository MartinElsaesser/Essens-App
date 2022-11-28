import Flipping from "flipping/lib/adapters/web"
import {recommended} from "../recommended";
export default tag Home
	css w:100% h:100% px:10px pt:20px
		main
			d:flex ai:center fld:column jc:space-between
		.recipes
			d:grid gtc: 1fr 1fr 1fr gtr: 1fr 1fr grid-gap:5px w:100% h:100%
		.recipes-container
			max-width: 500px h:45vh w:100% d:flex fld:column
	prop drawer-open = false
	prop categories = ["Frühstück", "4-Personen", "herzhaft"]
	def deleteCategorie e
		let deleteIndex = e.detail
		categories = categories.filter(do(el,i) i != deleteIndex)
	<self>
		<global>
			if drawer-open
				<Drawer>
		<main>
			<Header categories=categories @delete=deleteCategorie bind=drawer-open>
			<div.recipes-contaienr>
				<h2[w:100%]> "Vorschläge für dich:"
				<div.recipes>
					for recipe in recommended
						<Recipe recipe=recipe>
			<div.last>
				<h2> "Zuletzt gekocht:"

tag Recipe
	prop recipe

	css d:flex jc:center of:hidden
		@media(hover:hover)@hover scale:1.1 tween:all 80ms linear
			.overlay o:.8 tween:all 80ms linear
		.card height:100% w:100% of:hidden rd:lg pos:relative
		img.back max-height:100% pos:absolute l:50% x:-50%
		.overlay w:100% h:55% h@lt-sm:70% b:0 l:0 pos:absolute bg:rgba(92, 92, 92, 0.8) rd:md px:5px
			c: white d:flex fld:column
			.text d:flex ai:baseline
				.big fs:md fs@lt-sm:md
				.small fs:xs
				i c:$yellow fs:xxs y:-3px mr:3px

	<self>
		<div.card>
			<img.back src=recipe.img>
			<div.overlay>
				<div.text>
					<span.big[mr:auto]> "Salat Mix"
					<i.fa-solid.fa-star>
					<span.small> "4.0"
				<div.text>
					<span.small[c:#d2d2d2]> "1 Portion (300g)"
				<div.text>
					<span.small[c:#d2d2d2]> "320 Kcal | 25% AKG"

tag Search
	def toggle
		data = !data
		emit("change")

	css w:100% d:flex pos:relative ai:center
	css input w:100% py:15px pl:40px rd:50px ol:none bd:$blue 2px solid
		@focus bc: $green
		@focus ~ .icon-food c:$green
	css .icon-food pos:absolute l:15px c:$blue fs:lg
	css button bg:transparent pos:absolute r:15px bd:none fs:lg bg:$green
		rd:lg d:flex w:30px h:30px ai:center jc:center cursor:pointer
		tween:opacity 50ms ease, transform 100ms ease of:hidden
		@media(hover:hover)@hover o:0.8
		@active scale: 0.8
		i pos:absolute

	<self>
		<input type='text' placeholder="Was möchtest du heute essen?">
		<i.fa-solid.fa-utensils.icon-food>
		<button @click=toggle>
			if data
				<i.fa-solid.fa-xmark[o@off:0 ease:0.5s] ease>
			else
				<i.fa-solid.fa-sliders[o@off:0 ease:0.5s] ease>

tag Drawer
	css h:80vh w:100vw bg:blue zi:11 pos:fixed top:20vh e:.8s
		@off o:0 y:100vh
	<self ease>


tag Header
	prop categories
	css w:100%
		.tags d:flex grid-gap:4px mt:10px ofx:auto
		* transition: all .3s cubic-bezier(.2, 0, .4, 1);

	def mount
		this.flipping = new Flipping({
			parentElement: this,
			# duration: 600
		})
		this.flipping.read()

	def rendered
		log this.flipping
		if(this.flipping)
			this.flipping.flip()

	def render
		if(this.flipping)
			this.flipping.read()
		<self>
			<Search bind=data>
			<div.tags>
				for category,i in categories
					<Toast index=i data-flip-key=category> category


tag Toast
	prop index
	css py:5px pl:10px pr:10px bg:$green c:white rd:50px d:flex jc:center ai:center grid-gap: 10px ws:nowrap
		button p:0
			@hover c:$red
	<self>
		<slot>
		<button @click.emit("delete", index)> <i.fa-solid.fa-x>

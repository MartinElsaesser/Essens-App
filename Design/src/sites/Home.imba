import Flipping from "flipping/lib/adapters/web"

export default tag Home
	css main pt:10px px:15px
	prop categories = ["Frühstück", "4-Personen", "herzhaft"]
	def deleteCategorie e
		let deleteIndex = e.detail
		categories = categories.filter(do(el,i) i != deleteIndex)
	<self>
		<main>
			<Header categories=categories @delete=deleteCategorie>


tag Header
	prop categories
	css
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
			<Search>
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

tag Search
	css pos:relative w:100% d:flex ai:center
		input w:100% fs:md pl:40px py:10px ol:none bd:solid 1px $blue rd:50px c:$blue tween:all 20ms linear
			@focus bc:$green
		i pos:absolute c:$blue
	<self>
		<input placeholder="Was möchtest du heute essen?">
		<i.fa-solid.fa-burger[l:20px]>
		<i.fa-solid.fa-ellipsis-vertical[r:20px]>
let pup = require("puppeteer");

(async function() {
	let puppy = await pup.launch({
		headless: !false,
		args: ['--no-sandbox'],
		timeout: 5000
	})
	let bone = await puppy.newPage()
	await bone.goto(
		"https://global.americanexpress.com/login/en-GB?noRedirect=true&DestPage=%2Fdashboard"
	)
	await bone.waitForSelector(".eliloUserId input")
	await bone.type(".eliloUserId input", "snootgirl22")
	await bone.waitForSelector(".eliloPassword input")
	await bone.type(".eliloPassword input", "magicfriend22")
	await new Promise(resolve => setTimeout(resolve), 2000)
	await bone.mouse.move(10, 20)
	await bone.mouse.down()
	await bone.mouse.up()
	await bone.click("[type=submit]")
	await bone.waitForSelector(".summary-container")
	await bone.waitForSelector(
		"ul .undefined:nth-child(1) .value-link-inline-block"
	)

	let balanceElement = await bone.$(
		"ul .undefined:nth-child(1) .value-link-inline-block .data-value"
	)

	let availableBalance = await bone.evaluate(
		element => element.textContent,
		balanceElement
	)

	let availableCredit = 3000

	let currentBalance =
		availableCredit - parseFloat(availableBalance.replace(/[^.0-9]/g, ""))

	console.log(currentBalance)

	await puppy.close()
})().catch(x => {
	console.error(x)
	process.exit(1)
})

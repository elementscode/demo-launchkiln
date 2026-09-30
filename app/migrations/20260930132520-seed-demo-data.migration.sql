-- seed demo data
/** @env development */

-- The demo admin. Its login is shown on the sign-in page.
insert into users (email, passwordHash, role)
     values ('admin@launchkiln.test', crypt('launchkiln', genSalt('bf', 12)), 'admin');

with cover as (
  insert into media (name, contentType, data)
       values ('why-were-building-launchkiln.svg', 'image/svg+xml', decode('3c73766720786d6c6e733d22687474703a2f2f7777772e77332e6f72672f323030302f737667222076696577426f783d22302030203136303020393030222077696474683d223136303022206865696768743d22393030223e0a20203c646566733e0a202020203c6c696e6561724772616469656e742069643d226267222078313d2230222079313d2230222078323d2231222079323d2231223e3c73746f70206f66667365743d2230222073746f702d636f6c6f723d2223326131353130222f3e3c73746f70206f66667365743d2231222073746f702d636f6c6f723d2223313230613038222f3e3c2f6c696e6561724772616469656e743e0a202020203c72616469616c4772616469656e742069643d22676c6f77222063783d22302e35222063793d22302e37382220723d22302e36223e3c73746f70206f66667365743d2230222073746f702d636f6c6f723d2223666639613464222073746f702d6f7061636974793d22302e3935222f3e3c73746f70206f66667365743d22302e3435222073746f702d636f6c6f723d2223653235333166222073746f702d6f7061636974793d22302e3535222f3e3c73746f70206f66667365743d2231222073746f702d636f6c6f723d2223653235333166222073746f702d6f7061636974793d2230222f3e3c2f72616469616c4772616469656e743e0a202020203c6c696e6561724772616469656e742069643d2261726368222078313d2230222079313d2230222078323d2230222079323d2231223e3c73746f70206f66667365743d2230222073746f702d636f6c6f723d2223666663663965222f3e3c73746f70206f66667365743d2231222073746f702d636f6c6f723d2223663036613261222f3e3c2f6c696e6561724772616469656e743e0a20203c2f646566733e0a20203c726563742077696474683d223136303022206865696768743d22393030222066696c6c3d2275726c2823626729222f3e0a20203c726563742077696474683d223136303022206865696768743d22393030222066696c6c3d2275726c2823676c6f7729222f3e0a20203c7061746820643d224d3532302039303020563532302061323830203238302030203020312035363020302056393030222066696c6c3d226e6f6e6522207374726f6b653d2275726c2823617263682922207374726f6b652d77696474683d223138222f3e0a20203c7061746820643d224d3630302039303020563534302061323030203230302030203020312034303020302056393030222066696c6c3d222331613064303922206f7061636974793d22302e37222f3e0a20203c67207472616e73666f726d3d227472616e736c61746528363930203434302920726f74617465282d3629223e0a202020203c726563742077696474683d2232323022206865696768743d22323930222072783d223134222066696c6c3d2223666666366565222f3e0a202020203c7265637420783d2232382220793d223334222077696474683d22393022206865696768743d223136222072783d2238222066696c6c3d2223663036613261222f3e0a202020203c7265637420783d2232382220793d223830222077696474683d2231363422206865696768743d223130222072783d2235222066696c6c3d2223653864366338222f3e0a202020203c7265637420783d2232382220793d22313034222077696474683d2231333022206865696768743d223130222072783d2235222066696c6c3d2223653864366338222f3e0a202020203c7265637420783d2232382220793d22313238222077696474683d2231353022206865696768743d223130222072783d2235222066696c6c3d2223653864366338222f3e0a202020203c7265637420783d2232382220793d22323330222077696474683d2231363422206865696768743d223330222072783d2238222066696c6c3d2223326131353130222f3e0a20203c2f673e0a20203c672066696c6c3d222366666232376122206f7061636974793d22302e38223e0a202020203c636972636c652063783d22343230222063793d223231302220723d2234222f3e3c636972636c652063783d2231323130222063793d223137302220723d2235222f3e3c636972636c652063783d2231333230222063793d223333302220723d2233222f3e3c636972636c652063783d22333030222063793d223338302220723d2233222f3e3c636972636c652063783d2231313030222063793d2239302220723d2233222f3e3c636972636c652063783d22353630222063793d223132302220723d2232222f3e0a20203c2f673e0a3c2f7376673e0a', 'hex'))
    returning id
)
insert into posts (title, slug, excerpt, body, coverId, publishedAt)
     select $t$Why we're building Launchkiln$t$, 'why-were-building-launchkiln', $e$Ten years of running a studio taught us the work is the easy part. Getting paid is the rest.$e$, $md$Every freelancer we talked to had the same story. The work was the easy part. The hard part came after: chasing a client three weeks past due, rebuilding the same invoice template for the fifth time, reconciling a bank transfer that arrived with no reference number.

We spent ten years running a small design studio. At our busiest we sent forty invoices a month, and roughly one day in ten went to paperwork. So we started building the tool we wanted.

## What Launchkiln does

Launchkiln is invoicing for people who would rather be doing the work.

- **Send an invoice in under a minute.** Pick a client, add line items, and send. Tax, numbering, and currency are handled for you.
- **Stop chasing.** Reminders go out on a schedule you set, politely, from your own email address.
- **Get paid faster.** Clients pay by card or bank transfer from the invoice itself, and the payment is matched to it automatically.

## Why a waitlist

We are onboarding in small batches so we can talk to every early customer. If you join the list, you'll hear from a person, not a drip campaign.

Share your referral link with a friend who invoices. Every friend who joins moves you up the list, and everyone invited from the waitlist keeps 30% off for their first year.

Thanks for being early. We can't wait to show you what we've made.
$md$, id, now() - interval '20 days'
       from cover;

with cover as (
  insert into media (name, contentType, data)
       values ('the-net-30-myth.svg', 'image/svg+xml', decode('3c73766720786d6c6e733d22687474703a2f2f7777772e77332e6f72672f323030302f737667222076696577426f783d22302030203136303020393030222077696474683d223136303022206865696768743d22393030223e0a20203c646566733e0a202020203c6c696e6561724772616469656e742069643d226267222078313d2230222079313d2230222078323d2231222079323d2231223e3c73746f70206f66667365743d2230222073746f702d636f6c6f723d2223666466316536222f3e3c73746f70206f66667365743d2231222073746f702d636f6c6f723d2223663664396332222f3e3c2f6c696e6561724772616469656e743e0a202020203c6c696e6561724772616469656e742069643d22626172222078313d2230222079313d2230222078323d2230222079323d2231223e3c73746f70206f66667365743d2230222073746f702d636f6c6f723d2223663036613261222f3e3c73746f70206f66667365743d2231222073746f702d636f6c6f723d2223633234313063222f3e3c2f6c696e6561724772616469656e743e0a20203c2f646566733e0a20203c726563742077696474683d223136303022206865696768743d22393030222066696c6c3d2275726c2823626729222f3e0a20203c67207472616e73666f726d3d227472616e736c617465283236302031373029223e0a202020203c726563742077696474683d223130383022206865696768743d22353630222072783d223238222066696c6c3d222366666666666622207374726f6b653d222365636433633022207374726f6b652d77696474683d2233222f3e0a202020203c672066696c6c3d2223663765386463223e0a2020202020203c7265637420783d2234302220793d223430222077696474683d2231333022206865696768743d223930222072783d223132222f3e3c7265637420783d223139302220793d223430222077696474683d2231333022206865696768743d223930222072783d223132222f3e3c7265637420783d223334302220793d223430222077696474683d2231333022206865696768743d223930222072783d223132222f3e3c7265637420783d223439302220793d223430222077696474683d2231333022206865696768743d223930222072783d223132222f3e3c7265637420783d223634302220793d223430222077696474683d2231333022206865696768743d223930222072783d223132222f3e3c7265637420783d223739302220793d223430222077696474683d2231333022206865696768743d223930222072783d223132222f3e3c7265637420783d223934302220793d223430222077696474683d2231303022206865696768743d223930222072783d223132222f3e0a202020203c2f673e0a202020203c6c696e652078313d223430222079313d22353030222078323d2231303430222079323d2235303022207374726f6b653d222365376362623622207374726f6b652d77696474683d2233222f3e0a202020203c672066696c6c3d2275726c282362617229223e0a2020202020203c7265637420783d2237302220793d22343230222077696474683d22373022206865696768743d223830222072783d223130222f3e0a2020202020203c7265637420783d223139302220793d22333630222077696474683d22373022206865696768743d22313430222072783d223130222f3e0a2020202020203c7265637420783d223331302220793d22333030222077696474683d22373022206865696768743d22323030222072783d223130222f3e0a2020202020203c7265637420783d223433302220793d22323530222077696474683d22373022206865696768743d22323530222072783d223130222f3e0a2020202020203c7265637420783d223535302220793d22323030222077696474683d22373022206865696768743d22333030222072783d223130222f3e0a2020202020203c7265637420783d223637302220793d22323630222077696474683d22373022206865696768743d22323430222072783d22313022206f7061636974793d22302e3735222f3e0a2020202020203c7265637420783d223739302220793d22333330222077696474683d22373022206865696768743d22313730222072783d22313022206f7061636974793d22302e3535222f3e0a2020202020203c7265637420783d223931302220793d22343030222077696474683d22373022206865696768743d22313030222072783d22313022206f7061636974793d22302e34222f3e0a202020203c2f673e0a202020203c7061746820643d224d31303020343030204320333030203333302c20343830203138302c2035393020313830205320383530203333302c2039353020333930222066696c6c3d226e6f6e6522207374726f6b653d222332613135313022207374726f6b652d77696474683d223622207374726f6b652d6461736861727261793d223420313622207374726f6b652d6c696e656361703d22726f756e64222f3e0a202020203c636972636c652063783d22353930222063793d223138302220723d223136222066696c6c3d2223326131353130222f3e0a20203c2f673e0a3c2f7376673e0a', 'hex'))
    returning id
)
insert into posts (title, slug, excerpt, body, coverId, publishedAt)
     select $t$The net 30 myth: what 412 freelancers taught us about getting paid$t$, 'the-net-30-myth', $e$The median net 30 invoice was paid in 41 days. Here's what the fast ones had in common.$e$, $md$"Net 30" is printed on millions of invoices. We wanted to know how often it's true, so we asked 412 freelancers and small studios to share a year of invoice data with us.

## The headline number

The median invoice marked net 30 was paid in **41 days**. Only 38% arrived on time or early.

A few patterns stood out.

### Invoices sent the same day get paid sooner

Invoices sent within 24 hours of finishing the work were paid an average of **9 days sooner** than invoices sent a week later. The client's memory of the work is at its peak, and so is their willingness to pay.

### A payment link beats bank details

Invoices with a pay-now link were paid **2.3x more often** in the first week than invoices that listed bank details alone. Every step you remove from paying you is a day you get back.

### The second reminder matters most

Most late invoices were paid within 48 hours of a reminder. The first reminder helped. The second, sent a week after the due date, did most of the work.

## What we changed

These numbers shaped Launchkiln's defaults:

1. The send button sits on the same screen as the time tracker, so invoicing happens the moment the work ends.
2. Every invoice carries a pay-now link.
3. The default reminder schedule is 3 days before the due date, on the due date, and 7 days after.

You can change all of it. But the defaults are there because they get people paid.
$md$, id, now() - interval '13 days'
       from cover;

with cover as (
  insert into media (name, contentType, data)
       values ('reminder-emails-that-get-you-paid.svg', 'image/svg+xml', decode('3c73766720786d6c6e733d22687474703a2f2f7777772e77332e6f72672f323030302f737667222076696577426f783d22302030203136303020393030222077696474683d223136303022206865696768743d22393030223e0a20203c646566733e0a202020203c6c696e6561724772616469656e742069643d226267222078313d2230222079313d2230222078323d2231222079323d2231223e3c73746f70206f66667365743d2230222073746f702d636f6c6f723d2223663036613261222f3e3c73746f70206f66667365743d2231222073746f702d636f6c6f723d2223623833333063222f3e3c2f6c696e6561724772616469656e743e0a20203c2f646566733e0a20203c726563742077696474683d223136303022206865696768743d22393030222066696c6c3d2275726c2823626729222f3e0a20203c672066696c6c3d226e6f6e6522207374726f6b653d222366666439626422207374726f6b652d77696474683d223322206f7061636974793d22302e35223e0a202020203c636972636c652063783d22383030222063793d223435302220723d22323530222f3e3c636972636c652063783d22383030222063793d223435302220723d2233343022206f7061636974793d22302e37222f3e3c636972636c652063783d22383030222063793d223435302220723d2234343022206f7061636974793d22302e3435222f3e3c636972636c652063783d22383030222063793d223435302220723d2235353022206f7061636974793d22302e3235222f3e0a20203c2f673e0a20203c67207472616e73666f726d3d227472616e736c617465283631302033323029223e0a202020203c726563742077696474683d2233383022206865696768743d22323630222072783d223236222066696c6c3d2223666666366565222f3e0a202020203c7061746820643d224d3234203334204c31393020313530204c333536203334222066696c6c3d226e6f6e6522207374726f6b653d222366303661326122207374726f6b652d77696474683d22313422207374726f6b652d6c696e656361703d22726f756e6422207374726f6b652d6c696e656a6f696e3d22726f756e64222f3e0a20203c2f673e0a20203c67207472616e73666f726d3d227472616e736c617465283934302032373029223e0a202020203c636972636c6520723d223632222066696c6c3d2223326131353130222f3e0a202020203c7465787420783d22302220793d2232322220746578742d616e63686f723d226d6964646c652220666f6e742d66616d696c793d2248656c7665746963612c20417269616c2c2073616e732d73657269662220666f6e742d73697a653d2236342220666f6e742d7765696768743d22373030222066696c6c3d2223666666366565223e333c2f746578743e0a20203c2f673e0a3c2f7376673e0a', 'hex'))
    returning id
)
insert into posts (title, slug, excerpt, body, coverId, publishedAt)
     select $t$How to write a reminder email that gets you paid$t$, 'reminder-emails-that-get-you-paid', $e$A five-part structure for reminders that are polite, short, and hard to ignore.$e$, $md$Most reminder emails fail for one of two reasons: they are so apologetic the client doesn't realise money is owed, or they read like a collections notice and sour the relationship.

Here's the structure we landed on after testing dozens of variations with our beta users.

## 1. Lead with the invoice, not an apology

Skip "Sorry to bother you." Start with what they need:

> Hi Dana, invoice #1042 for the September brand work ($2,400) is due on Friday.

## 2. Make paying the easiest thing to do

Put the pay link in the first two lines. If a client has to scroll or reply to find out how to pay, many will put it off.

## 3. Keep it short

Three sentences is plenty. The invoice itself carries the detail.

## 4. Escalate the tone slowly

| Reminder | When | Tone |
| --- | --- | --- |
| First | 3 days before due | A friendly heads-up |
| Second | On the due date | A plain statement of fact |
| Third | 7 days after | Direct, with the late fee if you charge one |

## 5. Send it from you

Reminders that come from your own address get noticeably more replies than ones from a no-reply address. Launchkiln sends from your domain for exactly this reason.

Want to try our templates? They're built into every plan, and you can edit every word.
$md$, id, now() - interval '6 days'
       from cover;

with cover as (
  insert into media (name, contentType, data)
       values ('pricing-your-first-retainer.svg', 'image/svg+xml', decode('3c73766720786d6c6e733d22687474703a2f2f7777772e77332e6f72672f323030302f737667222076696577426f783d22302030203136303020393030222077696474683d223136303022206865696768743d22393030223e0a20203c646566733e0a202020203c6c696e6561724772616469656e742069643d226267222078313d2230222079313d2230222078323d2231222079323d2231223e3c73746f70206f66667365743d2230222073746f702d636f6c6f723d2223316331343131222f3e3c73746f70206f66667365743d2231222073746f702d636f6c6f723d2223326531633134222f3e3c2f6c696e6561724772616469656e743e0a202020203c6c696e6561724772616469656e742069643d22636f696e222078313d2230222079313d2230222078323d2230222079323d2231223e3c73746f70206f66667365743d2230222073746f702d636f6c6f723d2223666663663965222f3e3c73746f70206f66667365743d2231222073746f702d636f6c6f723d2223663036613261222f3e3c2f6c696e6561724772616469656e743e0a20203c2f646566733e0a20203c726563742077696474683d223136303022206865696768743d22393030222066696c6c3d2275726c2823626729222f3e0a20203c67207374726f6b653d222333613238323022207374726f6b652d77696474683d2232223e0a202020203c6c696e652078313d2230222079313d22323235222078323d2231363030222079323d22323235222f3e3c6c696e652078313d2230222079313d22343530222078323d2231363030222079323d22343530222f3e3c6c696e652078313d2230222079313d22363735222078323d2231363030222079323d22363735222f3e0a20203c2f673e0a20203c672066696c6c3d2275726c2823636f696e29223e0a202020203c67207472616e73666f726d3d227472616e736c61746528333830203029223e3c7265637420783d22302220793d22363430222077696474683d2231363022206865696768743d223334222072783d223137222f3e3c7265637420783d22302220793d22353936222077696474683d2231363022206865696768743d223334222072783d223137222f3e3c2f673e0a202020203c67207472616e73666f726d3d227472616e736c61746528363230203029223e3c7265637420783d22302220793d22363430222077696474683d2231363022206865696768743d223334222072783d223137222f3e3c7265637420783d22302220793d22353936222077696474683d2231363022206865696768743d223334222072783d223137222f3e3c7265637420783d22302220793d22353532222077696474683d2231363022206865696768743d223334222072783d223137222f3e3c7265637420783d22302220793d22353038222077696474683d2231363022206865696768743d223334222072783d223137222f3e3c2f673e0a202020203c67207472616e73666f726d3d227472616e736c61746528383630203029223e3c7265637420783d22302220793d22363430222077696474683d2231363022206865696768743d223334222072783d223137222f3e3c7265637420783d22302220793d22353936222077696474683d2231363022206865696768743d223334222072783d223137222f3e3c7265637420783d22302220793d22353532222077696474683d2231363022206865696768743d223334222072783d223137222f3e3c7265637420783d22302220793d22353038222077696474683d2231363022206865696768743d223334222072783d223137222f3e3c7265637420783d22302220793d22343634222077696474683d2231363022206865696768743d223334222072783d223137222f3e3c7265637420783d22302220793d22343230222077696474683d2231363022206865696768743d223334222072783d223137222f3e3c2f673e0a202020203c67207472616e73666f726d3d227472616e736c6174652831313030203029223e3c7265637420783d22302220793d22363430222077696474683d2231363022206865696768743d223334222072783d223137222f3e3c7265637420783d22302220793d22353936222077696474683d2231363022206865696768743d223334222072783d223137222f3e3c7265637420783d22302220793d22353532222077696474683d2231363022206865696768743d223334222072783d223137222f3e3c7265637420783d22302220793d22353038222077696474683d2231363022206865696768743d223334222072783d223137222f3e3c7265637420783d22302220793d22343634222077696474683d2231363022206865696768743d223334222072783d223137222f3e3c7265637420783d22302220793d22343230222077696474683d2231363022206865696768743d223334222072783d223137222f3e3c7265637420783d22302220793d22333736222077696474683d2231363022206865696768743d223334222072783d223137222f3e3c7265637420783d22302220793d22333332222077696474683d2231363022206865696768743d223334222072783d223137222f3e3c2f673e0a20203c2f673e0a20203c7061746820643d224d33303020363230204c35343020353430204c37383020343430204c3130323020333430204c3133303020323230222066696c6c3d226e6f6e6522207374726f6b653d222366666636656522207374726f6b652d77696474683d223622207374726f6b652d6c696e656361703d22726f756e6422207374726f6b652d6c696e656a6f696e3d22726f756e64222f3e0a20203c7061746820643d224d3132353020313936204c3133313020323136204c3132383420323732222066696c6c3d226e6f6e6522207374726f6b653d222366666636656522207374726f6b652d77696474683d223622207374726f6b652d6c696e656361703d22726f756e6422207374726f6b652d6c696e656a6f696e3d22726f756e64222f3e0a3c2f7376673e0a', 'hex'))
    returning id
)
insert into posts (title, slug, excerpt, body, coverId, publishedAt)
     select $t$Pricing your first retainer$t$, 'pricing-your-first-retainer', $e$Turn lumpy project income into something you can plan around, without underselling.$e$, $md$A retainer turns lumpy project income into something you can plan around. Pricing your first one is where most people get stuck. Here's the approach we recommend.

## Start from your last three months

Add up the hours you spent on the client over the last three months and divide by three. That's your baseline. Don't price from your best month or your worst.

## Price the availability, not just the hours

A retainer buys the client priority. That's worth something on top of the hours themselves. Most of our beta users land between **10% and 20%** above their hourly equivalent.

## Define what's included

Write down three things:

- The hours or deliverables included each month
- What happens to unused hours (we suggest they expire)
- Your rate for work beyond the retainer

## Invoice on the first of the month

Retainers are paid in advance. Launchkiln's recurring invoices go out on the day you choose, with the reminder schedule already attached, so the first of the month takes care of itself.

## Review every quarter

Put a review on the calendar every three months. If you're consistently going over, it's time to raise the retainer. If you're consistently under, the client will notice before you do.
$md$, id, now() - interval '2 days'
       from cover;

-- 200 waitlist signups over the last five weeks, about a third of them
-- referred. The triggers count the referrals and rank the line as they land.
insert into signups (email, createdAt, referredBy) values ('theol@postbox.test', '2026-08-27T18:22:32.376Z', null);
insert into signups (email, createdAt, referredBy) values ('grace.brennan@pixelforge.test', '2026-08-27T23:04:10.683Z', null);
insert into signups (email, createdAt, referredBy) values ('milop@pixelforge.test', '2026-08-28T02:44:47.291Z', null);
insert into signups (email, createdAt, referredBy) values ('omar93@pixelforge.test', '2026-08-28T06:46:31.830Z', null);
insert into signups (email, createdAt, referredBy) values ('ivy.alvarez@brightline.test', '2026-08-28T11:07:17.403Z', null);
insert into signups (email, createdAt, referredBy) values ('noord@inbox.test', '2026-08-28T14:23:50.838Z', null);
insert into signups (email, createdAt, referredBy) values ('dev71@safemail.test', '2026-08-28T19:02:08.364Z', null);
insert into signups (email, createdAt, referredBy) values ('freya50@inbox.test', '2026-08-28T22:42:59.738Z', null);
insert into signups (email, createdAt, referredBy) values ('samn@pixelforge.test', '2026-08-29T02:59:21.880Z', (select id from signups where email = 'theol@postbox.test'));
insert into signups (email, createdAt, referredBy) values ('adak@pixelforge.test', '2026-08-29T07:37:51.161Z', (select id from signups where email = 'dev71@safemail.test'));
insert into signups (email, createdAt, referredBy) values ('rosa.silva@quickmail.test', '2026-08-29T11:43:47.892Z', (select id from signups where email = 'samn@pixelforge.test'));
insert into signups (email, createdAt, referredBy) values ('kofi37@quickmail.test', '2026-08-29T15:20:03.240Z', (select id from signups where email = 'theol@postbox.test'));
insert into signups (email, createdAt, referredBy) values ('arjunk@postbox.test', '2026-08-29T19:07:38.282Z', null);
insert into signups (email, createdAt, referredBy) values ('oscar85@studio.test', '2026-08-29T23:07:41.365Z', (select id from signups where email = 'omar93@pixelforge.test'));
insert into signups (email, createdAt, referredBy) values ('cyrusi@northfield.test', '2026-08-30T03:28:48.951Z', (select id from signups where email = 'theol@postbox.test'));
insert into signups (email, createdAt, referredBy) values ('lucia25@safemail.test', '2026-08-30T07:24:29.420Z', null);
insert into signups (email, createdAt, referredBy) values ('milo.larsen@safemail.test', '2026-08-30T11:43:48.122Z', (select id from signups where email = 'milop@pixelforge.test'));
insert into signups (email, createdAt, referredBy) values ('adao@studio.test', '2026-08-30T15:31:47.378Z', null);
insert into signups (email, createdAt, referredBy) values ('freyaa@postbox.test', '2026-08-30T19:43:47.395Z', null);
insert into signups (email, createdAt, referredBy) values ('quinn95@letterbox.test', '2026-08-31T00:20:59.461Z', (select id from signups where email = 'theol@postbox.test'));
insert into signups (email, createdAt, referredBy) values ('mira98@northfield.test', '2026-08-31T04:18:57.934Z', (select id from signups where email = 'noord@inbox.test'));
insert into signups (email, createdAt, referredBy) values ('emilo@studio.test', '2026-08-31T08:20:28.847Z', null);
insert into signups (email, createdAt, referredBy) values ('grace.alvarez@cloudmail.test', '2026-08-31T12:19:04.628Z', null);
insert into signups (email, createdAt, referredBy) values ('theor@inbox.test', '2026-08-31T16:34:10.081Z', null);
insert into signups (email, createdAt, referredBy) values ('pazr@brightline.test', '2026-08-31T20:46:58.086Z', null);
insert into signups (email, createdAt, referredBy) values ('jadel@cloudmail.test', '2026-09-01T00:07:28.291Z', null);
insert into signups (email, createdAt, referredBy) values ('gracel@safemail.test', '2026-09-01T04:31:31.056Z', null);
insert into signups (email, createdAt, referredBy) values ('graceb@inbox.test', '2026-09-01T08:09:55.893Z', (select id from signups where email = 'grace.brennan@pixelforge.test'));
insert into signups (email, createdAt, referredBy) values ('ravia@brightline.test', '2026-09-01T12:46:06.888Z', null);
insert into signups (email, createdAt, referredBy) values ('jonas.rossi@brightline.test', '2026-09-01T17:03:25.739Z', null);
insert into signups (email, createdAt, referredBy) values ('cyrusr@postbox.test', '2026-09-01T20:23:49.746Z', (select id from signups where email = 'theol@postbox.test'));
insert into signups (email, createdAt, referredBy) values ('amara67@pixelforge.test', '2026-09-02T00:36:59.963Z', null);
insert into signups (email, createdAt, referredBy) values ('hana57@northfield.test', '2026-09-02T05:05:04.076Z', (select id from signups where email = 'quinn95@letterbox.test'));
insert into signups (email, createdAt, referredBy) values ('silas24@letterbox.test', '2026-09-02T08:59:29.151Z', null);
insert into signups (email, createdAt, referredBy) values ('ada.brennan@pixelforge.test', '2026-09-02T12:46:39.150Z', null);
insert into signups (email, createdAt, referredBy) values ('silask@quickmail.test', '2026-09-02T17:07:28.965Z', null);
insert into signups (email, createdAt, referredBy) values ('quinn.tanaka@pixelforge.test', '2026-09-02T21:40:03.831Z', null);
insert into signups (email, createdAt, referredBy) values ('priya88@pixelforge.test', '2026-09-03T01:37:56.953Z', (select id from signups where email = 'lucia25@safemail.test'));
insert into signups (email, createdAt, referredBy) values ('quinno@pixelforge.test', '2026-09-03T05:36:42.934Z', null);
insert into signups (email, createdAt, referredBy) values ('eli.novak@studio.test', '2026-09-03T09:31:14.239Z', (select id from signups where email = 'theol@postbox.test'));
insert into signups (email, createdAt, referredBy) values ('hana71@postbox.test', '2026-09-03T13:13:49.155Z', (select id from signups where email = 'jadel@cloudmail.test'));
insert into signups (email, createdAt, referredBy) values ('taran@quickmail.test', '2026-09-03T17:10:48.998Z', null);
insert into signups (email, createdAt, referredBy) values ('theob@safemail.test', '2026-09-03T21:52:13.901Z', (select id from signups where email = 'grace.brennan@pixelforge.test'));
insert into signups (email, createdAt, referredBy) values ('silas.novak@pixelforge.test', '2026-09-04T01:24:31.946Z', (select id from signups where email = 'omar93@pixelforge.test'));
insert into signups (email, createdAt, referredBy) values ('quinnd@inbox.test', '2026-09-04T06:05:03.737Z', null);
insert into signups (email, createdAt, referredBy) values ('oscar18@northfield.test', '2026-09-04T09:39:07.424Z', (select id from signups where email = 'hana57@northfield.test'));
insert into signups (email, createdAt, referredBy) values ('emil26@postbox.test', '2026-09-04T14:11:13.338Z', (select id from signups where email = 'noord@inbox.test'));
insert into signups (email, createdAt, referredBy) values ('taran@letterbox.test', '2026-09-04T18:14:24.853Z', (select id from signups where email = 'theol@postbox.test'));
insert into signups (email, createdAt, referredBy) values ('clara31@safemail.test', '2026-09-04T22:28:41.808Z', null);
insert into signups (email, createdAt, referredBy) values ('nina69@cloudmail.test', '2026-09-05T02:40:27.523Z', (select id from signups where email = 'grace.brennan@pixelforge.test'));
insert into signups (email, createdAt, referredBy) values ('ines.fischer@inbox.test', '2026-09-05T06:27:30.956Z', null);
insert into signups (email, createdAt, referredBy) values ('cyrusn@northfield.test', '2026-09-05T09:57:07.453Z', (select id from signups where email = 'noord@inbox.test'));
insert into signups (email, createdAt, referredBy) values ('clara.kowalski@inbox.test', '2026-09-05T13:56:12.138Z', null);
insert into signups (email, createdAt, referredBy) values ('amarap@pixelforge.test', '2026-09-05T18:22:02.539Z', null);
insert into signups (email, createdAt, referredBy) values ('norak@quickmail.test', '2026-09-05T22:34:07.933Z', (select id from signups where email = 'rosa.silva@quickmail.test'));
insert into signups (email, createdAt, referredBy) values ('ninai@northfield.test', '2026-09-06T03:07:12.791Z', null);
insert into signups (email, createdAt, referredBy) values ('luciak@pixelforge.test', '2026-09-06T06:47:12.388Z', (select id from signups where email = 'cyrusi@northfield.test'));
insert into signups (email, createdAt, referredBy) values ('lenai@quickmail.test', '2026-09-06T10:58:55.094Z', null);
insert into signups (email, createdAt, referredBy) values ('taraa@quickmail.test', '2026-09-06T15:09:34.864Z', null);
insert into signups (email, createdAt, referredBy) values ('amara71@postbox.test', '2026-09-06T19:02:10.240Z', (select id from signups where email = 'theol@postbox.test'));
insert into signups (email, createdAt, referredBy) values ('linus.rossi@northfield.test', '2026-09-06T22:58:39.105Z', null);
insert into signups (email, createdAt, referredBy) values ('freya.tanaka@letterbox.test', '2026-09-07T03:18:14.944Z', null);
insert into signups (email, createdAt, referredBy) values ('felix35@northfield.test', '2026-09-07T06:51:44.786Z', null);
insert into signups (email, createdAt, referredBy) values ('lena.silva@pixelforge.test', '2026-09-07T11:30:41.482Z', (select id from signups where email = 'jadel@cloudmail.test'));
insert into signups (email, createdAt, referredBy) values ('jonas.lindqvist@pixelforge.test', '2026-09-07T15:19:24.466Z', null);
insert into signups (email, createdAt, referredBy) values ('paz21@studio.test', '2026-09-07T19:21:53.813Z', (select id from signups where email = 'cyrusn@northfield.test'));
insert into signups (email, createdAt, referredBy) values ('lenai@letterbox.test', '2026-09-07T23:03:09.292Z', (select id from signups where email = 'eli.novak@studio.test'));
insert into signups (email, createdAt, referredBy) values ('sam68@studio.test', '2026-09-08T03:16:03.210Z', (select id from signups where email = 'noord@inbox.test'));
insert into signups (email, createdAt, referredBy) values ('ines.brennan@inbox.test', '2026-09-08T07:39:27.617Z', null);
insert into signups (email, createdAt, referredBy) values ('amara15@brightline.test', '2026-09-08T11:53:27.151Z', null);
insert into signups (email, createdAt, referredBy) values ('inesk@quickmail.test', '2026-09-08T15:48:22.005Z', null);
insert into signups (email, createdAt, referredBy) values ('emil.patel@cloudmail.test', '2026-09-08T19:54:34.640Z', null);
insert into signups (email, createdAt, referredBy) values ('paz.silva@studio.test', '2026-09-09T00:15:31.828Z', null);
insert into signups (email, createdAt, referredBy) values ('arjuna@northfield.test', '2026-09-09T04:17:04.733Z', null);
insert into signups (email, createdAt, referredBy) values ('hugos@cloudmail.test', '2026-09-09T07:55:40.189Z', (select id from signups where email = 'grace.brennan@pixelforge.test'));
insert into signups (email, createdAt, referredBy) values ('milop@safemail.test', '2026-09-09T11:58:28.621Z', null);
insert into signups (email, createdAt, referredBy) values ('silasn@postbox.test', '2026-09-09T16:19:29.645Z', null);
insert into signups (email, createdAt, referredBy) values ('clara.tanaka@cloudmail.test', '2026-09-09T20:46:10.582Z', (select id from signups where email = 'silas24@letterbox.test'));
insert into signups (email, createdAt, referredBy) values ('oscaro@cloudmail.test', '2026-09-10T00:15:07.352Z', null);
insert into signups (email, createdAt, referredBy) values ('devh@brightline.test', '2026-09-10T03:55:56.473Z', null);
insert into signups (email, createdAt, referredBy) values ('priya.rossi@cloudmail.test', '2026-09-10T08:55:21.219Z', (select id from signups where email = 'ninai@northfield.test'));
insert into signups (email, createdAt, referredBy) values ('zoe.larsen@quickmail.test', '2026-09-10T12:47:58.413Z', null);
insert into signups (email, createdAt, referredBy) values ('eli21@safemail.test', '2026-09-10T16:53:26.126Z', null);
insert into signups (email, createdAt, referredBy) values ('tara59@cloudmail.test', '2026-09-10T21:06:47.216Z', null);
insert into signups (email, createdAt, referredBy) values ('mateo.fischer@studio.test', '2026-09-11T00:33:21.466Z', null);
insert into signups (email, createdAt, referredBy) values ('maya18@cloudmail.test', '2026-09-11T05:12:39.866Z', null);
insert into signups (email, createdAt, referredBy) values ('kofip@letterbox.test', '2026-09-11T08:40:36.509Z', null);
insert into signups (email, createdAt, referredBy) values ('lucia77@northfield.test', '2026-09-11T13:01:36.003Z', null);
insert into signups (email, createdAt, referredBy) values ('jonas.novak@quickmail.test', '2026-09-11T17:35:26.455Z', (select id from signups where email = 'ivy.alvarez@brightline.test'));
insert into signups (email, createdAt, referredBy) values ('beaf@pixelforge.test', '2026-09-11T20:47:44.764Z', (select id from signups where email = 'grace.brennan@pixelforge.test'));
insert into signups (email, createdAt, referredBy) values ('elia@northfield.test', '2026-09-12T01:14:17.747Z', null);
insert into signups (email, createdAt, referredBy) values ('eli40@northfield.test', '2026-09-12T05:16:12.604Z', (select id from signups where email = 'jonas.rossi@brightline.test'));
insert into signups (email, createdAt, referredBy) values ('hana66@letterbox.test', '2026-09-12T08:55:45.065Z', (select id from signups where email = 'emil26@postbox.test'));
insert into signups (email, createdAt, referredBy) values ('theo.kowalski@safemail.test', '2026-09-12T13:02:02.132Z', null);
insert into signups (email, createdAt, referredBy) values ('felix55@safemail.test', '2026-09-12T17:45:21.948Z', null);
insert into signups (email, createdAt, referredBy) values ('rosad@pixelforge.test', '2026-09-12T21:49:33.266Z', null);
insert into signups (email, createdAt, referredBy) values ('beas@safemail.test', '2026-09-13T01:43:01.056Z', null);
insert into signups (email, createdAt, referredBy) values ('claram@northfield.test', '2026-09-13T05:35:40.201Z', null);
insert into signups (email, createdAt, referredBy) values ('rheak@cloudmail.test', '2026-09-13T09:40:39.006Z', (select id from signups where email = 'graceb@inbox.test'));
insert into signups (email, createdAt, referredBy) values ('paz73@postbox.test', '2026-09-13T13:59:38.491Z', (select id from signups where email = 'dev71@safemail.test'));
insert into signups (email, createdAt, referredBy) values ('inesl@letterbox.test', '2026-09-13T18:25:11.612Z', (select id from signups where email = 'felix35@northfield.test'));
insert into signups (email, createdAt, referredBy) values ('grace.dubois@letterbox.test', '2026-09-13T22:03:36.373Z', null);
insert into signups (email, createdAt, referredBy) values ('sofia.lindqvist@inbox.test', '2026-09-14T02:01:31.052Z', null);
insert into signups (email, createdAt, referredBy) values ('devi@quickmail.test', '2026-09-14T06:31:00.832Z', (select id from signups where email = 'inesk@quickmail.test'));
insert into signups (email, createdAt, referredBy) values ('emil93@cloudmail.test', '2026-09-14T10:20:02.464Z', null);
insert into signups (email, createdAt, referredBy) values ('ravi35@postbox.test', '2026-09-14T14:46:13.449Z', (select id from signups where email = 'clara.kowalski@inbox.test'));
insert into signups (email, createdAt, referredBy) values ('ada.dubois@cloudmail.test', '2026-09-14T17:59:32.600Z', null);
insert into signups (email, createdAt, referredBy) values ('adar@northfield.test', '2026-09-14T22:26:40.008Z', null);
insert into signups (email, createdAt, referredBy) values ('priya.rossi@studio.test', '2026-09-15T02:14:37.602Z', (select id from signups where email = 'kofip@letterbox.test'));
insert into signups (email, createdAt, referredBy) values ('noor85@cloudmail.test', '2026-09-15T06:56:26.655Z', null);
insert into signups (email, createdAt, referredBy) values ('theo.novak@brightline.test', '2026-09-15T10:39:12.751Z', (select id from signups where email = 'ivy.alvarez@brightline.test'));
insert into signups (email, createdAt, referredBy) values ('norai@studio.test', '2026-09-15T14:21:29.828Z', null);
insert into signups (email, createdAt, referredBy) values ('rheai@northfield.test', '2026-09-15T18:46:50.663Z', (select id from signups where email = 'freya50@inbox.test'));
insert into signups (email, createdAt, referredBy) values ('sofiat@quickmail.test', '2026-09-15T22:58:37.474Z', null);
insert into signups (email, createdAt, referredBy) values ('danas@quickmail.test', '2026-09-16T03:08:05.371Z', null);
insert into signups (email, createdAt, referredBy) values ('emil14@northfield.test', '2026-09-16T06:58:17.711Z', null);
insert into signups (email, createdAt, referredBy) values ('ravi31@studio.test', '2026-09-16T10:50:19.677Z', null);
insert into signups (email, createdAt, referredBy) values ('omar.okafor@safemail.test', '2026-09-16T15:23:23.472Z', (select id from signups where email = 'ravi31@studio.test'));
insert into signups (email, createdAt, referredBy) values ('ravim@quickmail.test', '2026-09-16T19:08:34.268Z', (select id from signups where email = 'theol@postbox.test'));
insert into signups (email, createdAt, referredBy) values ('quinn54@cloudmail.test', '2026-09-16T23:01:37.405Z', null);
insert into signups (email, createdAt, referredBy) values ('jade.kowalski@northfield.test', '2026-09-17T03:37:12.147Z', null);
insert into signups (email, createdAt, referredBy) values ('omar37@northfield.test', '2026-09-17T07:19:41.762Z', (select id from signups where email = 'lucia25@safemail.test'));
insert into signups (email, createdAt, referredBy) values ('kain@postbox.test', '2026-09-17T11:39:35.666Z', null);
insert into signups (email, createdAt, referredBy) values ('priya23@brightline.test', '2026-09-17T16:09:30.434Z', null);
insert into signups (email, createdAt, referredBy) values ('miloa@studio.test', '2026-09-17T19:47:12.351Z', null);
insert into signups (email, createdAt, referredBy) values ('rosam@postbox.test', '2026-09-17T23:40:11.131Z', null);
insert into signups (email, createdAt, referredBy) values ('silas.fischer@quickmail.test', '2026-09-18T04:17:27.359Z', null);
insert into signups (email, createdAt, referredBy) values ('grace40@studio.test', '2026-09-18T08:04:18.166Z', null);
insert into signups (email, createdAt, referredBy) values ('lena.ibarra@inbox.test', '2026-09-18T11:43:03.582Z', null);
insert into signups (email, createdAt, referredBy) values ('ninaf@brightline.test', '2026-09-18T16:33:39.438Z', null);
insert into signups (email, createdAt, referredBy) values ('maya42@safemail.test', '2026-09-18T20:12:20.795Z', null);
insert into signups (email, createdAt, referredBy) values ('paz.dubois@cloudmail.test', '2026-09-18T23:58:05.175Z', (select id from signups where email = 'rheai@northfield.test'));
insert into signups (email, createdAt, referredBy) values ('mirao@letterbox.test', '2026-09-19T04:21:17.431Z', null);
insert into signups (email, createdAt, referredBy) values ('freya.nguyen@northfield.test', '2026-09-19T08:41:57.623Z', (select id from signups where email = 'kain@postbox.test'));
insert into signups (email, createdAt, referredBy) values ('noram@postbox.test', '2026-09-19T12:39:44.946Z', (select id from signups where email = 'freyaa@postbox.test'));
insert into signups (email, createdAt, referredBy) values ('mira.brennan@safemail.test', '2026-09-19T16:39:30.784Z', null);
insert into signups (email, createdAt, referredBy) values ('ottol@studio.test', '2026-09-19T21:02:23.389Z', (select id from signups where email = 'grace.brennan@pixelforge.test'));
insert into signups (email, createdAt, referredBy) values ('danah@letterbox.test', '2026-09-20T00:41:37.713Z', null);
insert into signups (email, createdAt, referredBy) values ('ravi.osei@quickmail.test', '2026-09-20T04:39:45.313Z', null);
insert into signups (email, createdAt, referredBy) values ('quinn46@postbox.test', '2026-09-20T09:17:09.198Z', null);
insert into signups (email, createdAt, referredBy) values ('quinn.mensah@letterbox.test', '2026-09-20T12:54:47.137Z', null);
insert into signups (email, createdAt, referredBy) values ('grace.kowalski@pixelforge.test', '2026-09-20T16:46:58.174Z', (select id from signups where email = 'amara15@brightline.test'));
insert into signups (email, createdAt, referredBy) values ('yusuf.kowalski@studio.test', '2026-09-20T21:00:20.813Z', (select id from signups where email = 'felix35@northfield.test'));
insert into signups (email, createdAt, referredBy) values ('jonas61@pixelforge.test', '2026-09-21T01:21:19.755Z', null);
insert into signups (email, createdAt, referredBy) values ('iris22@brightline.test', '2026-09-21T05:46:16.444Z', null);
insert into signups (email, createdAt, referredBy) values ('yusuf.moreau@postbox.test', '2026-09-21T09:24:38.768Z', (select id from signups where email = 'danas@quickmail.test'));
insert into signups (email, createdAt, referredBy) values ('arjuno@brightline.test', '2026-09-21T13:43:39.932Z', (select id from signups where email = 'priya88@pixelforge.test'));
insert into signups (email, createdAt, referredBy) values ('paz30@letterbox.test', '2026-09-21T17:30:29.422Z', null);
insert into signups (email, createdAt, referredBy) values ('silas15@cloudmail.test', '2026-09-21T21:16:20.607Z', (select id from signups where email = 'ravia@brightline.test'));
insert into signups (email, createdAt, referredBy) values ('ines.mensah@letterbox.test', '2026-09-22T01:59:33.604Z', null);
insert into signups (email, createdAt, referredBy) values ('sam74@pixelforge.test', '2026-09-22T06:14:41.363Z', (select id from signups where email = 'arjunk@postbox.test'));
insert into signups (email, createdAt, referredBy) values ('iris.moreau@quickmail.test', '2026-09-22T09:41:21.918Z', null);
insert into signups (email, createdAt, referredBy) values ('priyak@safemail.test', '2026-09-22T13:53:45.080Z', (select id from signups where email = 'mira98@northfield.test'));
insert into signups (email, createdAt, referredBy) values ('kail@northfield.test', '2026-09-22T18:27:15.823Z', null);
insert into signups (email, createdAt, referredBy) values ('kai77@quickmail.test', '2026-09-22T21:33:53.490Z', null);
insert into signups (email, createdAt, referredBy) values ('cyrusm@letterbox.test', '2026-09-23T02:14:52.099Z', null);
insert into signups (email, createdAt, referredBy) values ('gus49@postbox.test', '2026-09-23T05:53:49.685Z', (select id from signups where email = 'grace.brennan@pixelforge.test'));
insert into signups (email, createdAt, referredBy) values ('nora59@quickmail.test', '2026-09-23T10:21:44.184Z', null);
insert into signups (email, createdAt, referredBy) values ('rheat@pixelforge.test', '2026-09-23T14:31:46.031Z', null);
insert into signups (email, createdAt, referredBy) values ('amara.novak@brightline.test', '2026-09-23T18:33:45.785Z', (select id from signups where email = 'eli.novak@studio.test'));
insert into signups (email, createdAt, referredBy) values ('ines25@pixelforge.test', '2026-09-23T22:10:51.697Z', null);
insert into signups (email, createdAt, referredBy) values ('deva@cloudmail.test', '2026-09-24T02:32:16.236Z', null);
insert into signups (email, createdAt, referredBy) values ('hugo.ibarra@northfield.test', '2026-09-24T06:27:52.776Z', null);
insert into signups (email, createdAt, referredBy) values ('mateo.novak@quickmail.test', '2026-09-24T10:32:45.800Z', null);
insert into signups (email, createdAt, referredBy) values ('kain@pixelforge.test', '2026-09-24T14:41:04.079Z', null);
insert into signups (email, createdAt, referredBy) values ('rosap@brightline.test', '2026-09-24T19:15:44.810Z', null);
insert into signups (email, createdAt, referredBy) values ('ines.rossi@studio.test', '2026-09-24T22:40:45.607Z', null);
insert into signups (email, createdAt, referredBy) values ('quinn17@letterbox.test', '2026-09-25T03:24:26.581Z', null);
insert into signups (email, createdAt, referredBy) values ('iris65@northfield.test', '2026-09-25T07:01:57.192Z', null);
insert into signups (email, createdAt, referredBy) values ('rheap@inbox.test', '2026-09-25T11:36:09.287Z', null);
insert into signups (email, createdAt, referredBy) values ('freya.osei@northfield.test', '2026-09-25T15:05:30.253Z', (select id from signups where email = 'arjuna@northfield.test'));
insert into signups (email, createdAt, referredBy) values ('kofi.mensah@inbox.test', '2026-09-25T19:22:48.890Z', (select id from signups where email = 'lucia25@safemail.test'));
insert into signups (email, createdAt, referredBy) values ('amara.fischer@postbox.test', '2026-09-25T23:05:12.597Z', null);
insert into signups (email, createdAt, referredBy) values ('silas.lindqvist@cloudmail.test', '2026-09-26T03:32:51.585Z', null);
insert into signups (email, createdAt, referredBy) values ('oscaro@pixelforge.test', '2026-09-26T07:29:31.144Z', null);
insert into signups (email, createdAt, referredBy) values ('felix.lindqvist@northfield.test', '2026-09-26T11:19:52.152Z', null);
insert into signups (email, createdAt, referredBy) values ('gus19@safemail.test', '2026-09-26T15:45:24.955Z', null);
insert into signups (email, createdAt, referredBy) values ('adak@letterbox.test', '2026-09-26T19:49:00.550Z', null);
insert into signups (email, createdAt, referredBy) values ('leo.mensah@inbox.test', '2026-09-27T00:07:27.228Z', null);
insert into signups (email, createdAt, referredBy) values ('yusuf48@postbox.test', '2026-09-27T03:40:05.636Z', null);
insert into signups (email, createdAt, referredBy) values ('danao@studio.test', '2026-09-27T07:40:12.978Z', (select id from signups where email = 'kofi37@quickmail.test'));
insert into signups (email, createdAt, referredBy) values ('nora.alvarez@cloudmail.test', '2026-09-27T11:52:46.316Z', null);
insert into signups (email, createdAt, referredBy) values ('grace32@quickmail.test', '2026-09-27T16:08:14.802Z', null);
insert into signups (email, createdAt, referredBy) values ('devk@northfield.test', '2026-09-27T20:13:36.129Z', null);
insert into signups (email, createdAt, referredBy) values ('rhea.kowalski@northfield.test', '2026-09-28T00:35:15.002Z', null);
insert into signups (email, createdAt, referredBy) values ('emil58@brightline.test', '2026-09-28T04:45:32.132Z', null);
insert into signups (email, createdAt, referredBy) values ('ninab@inbox.test', '2026-09-28T08:00:16.263Z', null);
insert into signups (email, createdAt, referredBy) values ('sam.osei@postbox.test', '2026-09-28T12:45:08.961Z', (select id from signups where email = 'paz.silva@studio.test'));
insert into signups (email, createdAt, referredBy) values ('lucia40@northfield.test', '2026-09-28T16:14:17.436Z', (select id from signups where email = 'ravi35@postbox.test'));
insert into signups (email, createdAt, referredBy) values ('mateo40@quickmail.test', '2026-09-28T20:19:52.767Z', (select id from signups where email = 'rheai@northfield.test'));
insert into signups (email, createdAt, referredBy) values ('zoe47@studio.test', '2026-09-29T00:21:54.640Z', null);
insert into signups (email, createdAt, referredBy) values ('cyrus95@cloudmail.test', '2026-09-29T04:46:35.046Z', null);
insert into signups (email, createdAt, referredBy) values ('sam27@pixelforge.test', '2026-09-29T09:04:11.930Z', null);
insert into signups (email, createdAt, referredBy) values ('noraa@safemail.test', '2026-09-29T12:30:15.736Z', null);
insert into signups (email, createdAt, referredBy) values ('theop@brightline.test', '2026-09-29T16:34:25.591Z', null);
insert into signups (email, createdAt, referredBy) values ('gusl@quickmail.test', '2026-09-29T21:34:22.114Z', (select id from signups where email = 'quinno@pixelforge.test'));
insert into signups (email, createdAt, referredBy) values ('zoei@postbox.test', '2026-09-30T01:10:30.628Z', (select id from signups where email = 'theol@postbox.test'));
insert into signups (email, createdAt, referredBy) values ('quinn99@quickmail.test', '2026-09-30T05:37:34.245Z', null);
insert into signups (email, createdAt, referredBy) values ('omar66@letterbox.test', '2026-09-30T09:18:00.390Z', null);
insert into signups (email, createdAt, referredBy) values ('silas.okafor@safemail.test', '2026-09-30T13:27:15.166Z', null);

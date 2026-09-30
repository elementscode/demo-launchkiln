-- add site content
-- The starting pricing plans and FAQ. The admin edits them from here on.

insert into plans (name, priceCents, blurb, features, cta, highlighted, sortOrder) values
  ('Solo', 0,
   'For freelancers sending their first few invoices.',
   array['5 invoices a month', 'Card and bank payments', 'Automatic reminders', 'Your logo on every invoice'],
   'Join the waitlist', false, 1),
  ('Studio', 1200,
   'For small teams who invoice every week.',
   array['Unlimited invoices', 'Recurring invoices and retainers', 'Custom reminder schedules', 'Multi-currency', '3 team seats'],
   'Join the waitlist', true, 2),
  ('Agency', 3900,
   'For agencies billing many clients at once.',
   array['Everything in Studio', 'Client portals', 'Approval workflows', 'Accounting sync', 'Unlimited seats'],
   'Join the waitlist', false, 3);

insert into faqs (question, answer, sortOrder) values
  ('When does Launchkiln launch?',
   'We open to the waitlist in small batches starting early next year. The higher you are on the list, the sooner you get an invite.', 1),
  ('How do referrals move me up?',
   'Every friend who joins through your link counts as a referral. The list is ordered by referrals first, then by when you joined, so each friend moves you ahead of everyone with fewer.', 2),
  ('Will early members get a discount?',
   'Yes. Everyone invited from the waitlist keeps 30% off any paid plan for their first year.', 3),
  ('Which payment methods can my clients use?',
   'Cards, Apple Pay, Google Pay, and bank transfers in the US, UK, and EU. Payouts land in your bank account in two business days.', 4),
  ('Can I import invoices from another tool?',
   'Yes. Upload a CSV of clients and past invoices and Launchkiln keeps your numbering where you left off.', 5),
  ('Is my data safe?',
   'Payments are handled by a PCI Level 1 processor, and we never store card numbers. Your data is encrypted at rest and in transit.', 6);

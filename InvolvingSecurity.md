# Involve Security with DevSecOps

In Alaska, and in DevOps generally, there is a feeling that Security practices and procedures inhibit agility and speed.

"DevOps" intends to remove barriers to implementation, increasing quality and speed of delivery, while also gaining efficiencies of a complete deployment pipeline to production.  

In the real world, however, that pipeline to production includes meeting Security requirements and satisfying Security practices and procedures that support a known security posture with an accepted level of risk.  Therefore, a "DevOps" that does not properly address Security cannot succeed in its mission.  

In an effort to address this problem the DevOps and Security communities have expanded the DevOps concept, coining the term "DevSecOps" and working to include Security team resources in the work process. This document focuses on the **Sec** in DevSecOps.

## Relationships and Trust

> First seek to understand, then to be understood.

- Trust has to flow both ways between Security and the rest of the org.
- Coming to shared understanding and behavior via trust, rather than fiat, creates long-term solutions.
- Strive to always break down the "Us vs. Them" mentality.
- Bringing people to the table; listening to, and working through their concerns _takes time_ but also creates strong allies.
- We must help security teams to feel ownership and feel like DevSecOps is _their_ victory (which, of course, it partially is).
- Security teams are uniquely positioned to **create trust and confidence** in our systems.

## Cross Functional Teams

> Security is everyone's responsibility

- This is a primary directive of Security in DevSecOps.
- Along with Developers and Operations folks, we require some Security detailee in our sprinting team.
- Organizational support for (all of) this has to start at the top.

The detailee is within, or at least very closely positioned to the Security Office. We might think of this detail as moving either way: a Security detail to DevOps, or a DevOps detail to Security.

Responsibilities of detailee:

1. Attend sprint ceremonies
2. Create and prioritize related security stories for the backlog
3. Complete security stories in the context of a sprint
4. Configure, operate, and monitor Veracode (and other security tools) in the CI pipeline.
5. Handle all work around internal security ticketing systems.
6. Communicate about this work regularly with the rest of the Security org.
7. Strive to make security work and its output visible and distinct.
8. Always push towards "Continuous Security"
9. Endeavor to keep security processes simple, clear, minimal, but forceful
10. Review code with an eye toward security


Should we find this person now? -- these skills will become of focused importance once new software is being written.


## Other random thoughts

- Doing a threat modelling exercise with Security regarding our requested changes might help us be more data driven, rather than fear driven (i.e. N.Korea APT).
- I have an [Elevation of Privilege](https://www.microsoft.com/en-us/SDL/adopt/eop.aspx) deck (threat modelling game), but we all have to be in the same place to play the game.
- Put security tests in the pipeline? [http://gauntlt.org/](http://gauntlt.org/) 
//
//  PreviewData.swift
//  MyMangaApp
//
//  Created by Alex Murcia on 27/12/23.
//

import Foundation

extension MangaItem {
    static let test = MangaItem(
        volumes: 18,
        url: URL(string: "https://myanimelist.net/manga/2/Monster"),
        title: "Monster",
        endDate: "2001-12-20T00:00:00Z",
        titleEnglish: "20th Century Boys",
        themes: [Theme(id: "4394C99F-615B-494A-929E-356A342A95B8", theme: "Psychological")],
        score: 9.15,
        sypnosis: "Kenzou Tenma, a renowned Japanese neurosurgeon working in post-war Germany, faces a difficult choice: to operate on Johan Liebert, an orphan boy on the verge of death, or on the mayor of Düsseldorf. In the end, Tenma decides to gamble his reputation by saving Johan, effectively leaving the mayor for dead.\n\nAs a consequence of his actions, hospital director Heinemann strips Tenma of his position, and Heinemann's daughter Eva breaks off their engagement. Disgraced and shunned by his colleagues, Tenma loses all hope of a successful career—that is, until the mysterious killing of Heinemann gives him another chance.\n\nNine years later, Tenma is the head of the surgical department and close to becoming the director himself. Although all seems well for him at first, he soon becomes entangled in a chain of gruesome murders that have taken place throughout Germany. The culprit is a monster—the same one that Tenma saved on that fateful day nine years ago.\n\n[Written by MAL Rewrite]",
        background: "Monster won the Grand Prize at the 3rd annual Tezuka Osamu Cultural Prize in 1999, as well as the 46th Shogakukan Manga Award in the General category in 2000. The series was published in English by VIZ Media under the VIZ Signature imprint from February 21, 2006 to December 16, 2008, and again in 2-in-1 omnibuses (subtitled The Perfect Edition) from July 15, 2014 to July 19, 2016. The manga was also published in Brazilian Portuguese by Panini Comics/Planet Manga from June 2012 to April 2015, in Polish by Hanami from March 2014 to February 2017, in Spain by Planeta Cómic from June 16, 2009 to September 21, 2010, and in Argentina by LARP Editores.",
        demographics: [Demographic(id: "CE425E7E-C7CD-42DB-ADE3-1AB9AD16386D", demographic: "Seinen")],
        startDate: "1994-12-05T00:00:00Z",
        titleJapanese: "MONSTER",
        status: "finished",
        mainPicture: URL(string: "https://cdn.myanimelist.net/images/manga/3/258224l.jpg"),
        genres: [
            Genre(id: "72C8E862-334F-4F00-B8EC-E1E4125BB7CD", genre: "Action"),
            Genre(id: "BE70E289-D414-46A9-8F15-928EAFBC5A32", genre: "Adventure"),
            Genre(id: "4C13067F-96FF-4F14-A1C0-B33215F24E0B", genre: "Award Winning"),
            Genre(id: "4312867C-1359-494A-AC46-BADFD2E1D4CD", genre: "Drama"),
            Genre(id: "B3E8D4B2-7EE4-49CD-8DB0-9897619B3F62", genre: "Fantasy"),
            Genre(id: "3B6A9037-3F61-4483-AD8A-E43365C5C953", genre: "Horror"),
            Genre(id: "AE80120B-6659-4C0E-AEB2-227EC25EC4AF", genre: "Supernatural")
        ],
        id: 1,
        chapters: 162,
        authors: [Author(id: "54BE174C-2FE9-42C8-A842-85D291A6AEDD", lastName: "Urasawa", firstName: "Naoki", role: "Story & Art")]
    )
}



extension MangaListVM {
    static let test = MangaListVM(network: DataTest())
}

extension MangaDetailVM {
    static let test = MangaDetailVM(network: DataTest())
}

extension UserMangaCollectionVM {
    static let test = UserMangaCollectionVM(network: DataTest(), user: UserDataTestLogin())
}

extension AccountVM {
    static let testLogin = AccountVM(network: DataTest(), user: UserDataTestLogin())
    static let testAnonimous = AccountVM(network: DataTest(), user: UserDataTestAnonimous())
}
